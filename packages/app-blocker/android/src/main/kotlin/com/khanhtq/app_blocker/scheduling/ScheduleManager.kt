package com.khanhtq.app_blocker.scheduling

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import com.google.gson.reflect.TypeToken
import com.khanhtq.app_blocker.blocking.BlockingServiceManager
import com.khanhtq.app_blocker.persistence.BlockerPreferences
import java.util.Calendar

/**
 * Represents a single time-based blocking schedule.
 *
 * Instances are serialised to / from JSON via Gson and stored in
 * [BlockerPreferences]. [toMap] converts to the wire format expected by
 * the Dart side.
 */
data class ScheduleData(
    @SerializedName("id") val id: String,
    @SerializedName("name") val name: String,
    @SerializedName("appIdentifiers") val appIdentifiers: List<String>,
    /** ISO 8601 weekday numbers: 1 = Monday … 7 = Sunday. */
    @SerializedName("weekdays") val weekdays: List<Int>,
    @SerializedName("startHour") val startHour: Int,
    @SerializedName("startMinute") val startMinute: Int,
    @SerializedName("endHour") val endHour: Int,
    @SerializedName("endMinute") val endMinute: Int,
    @SerializedName("enabled") val enabled: Boolean,
    /**
     * Specific date for one-time schedules (milliseconds since epoch).
     * When null, this is a recurring schedule that repeats on [weekdays].
     * When set, this is a one-time schedule that runs only on this date.
     */
    @SerializedName("scheduleDate") val scheduleDate: Long? = null,
) {
    /** Converts this instance to the map format sent over the Flutter channel. */
    fun toMap(): Map<String, Any?> = buildMap {
        put("id", id)
        put("name", name)
        put("appIdentifiers", appIdentifiers)
        put("weekdays", weekdays)
        put("startHour", startHour)
        put("startMinute", startMinute)
        put("endHour", endHour)
        put("endMinute", endMinute)
        put("enabled", enabled)
        scheduleDate?.let { put("scheduleDate", it) }
    }

    companion object {
        /**
         * Constructs a [ScheduleData] from a Flutter channel map.
         *
         * List elements come across as heterogeneous [List<*>]; we use
         * [filterIsInstance] / [map] to recover type safety without
         * unchecked casts.
         *
         * @throws IllegalArgumentException if any weekday is outside the ISO 8601 range (1–7).
         */
        fun fromMap(data: Map<String, Any?>): ScheduleData {
            val appIdentifiers = (data["appIdentifiers"] as? List<*>)
                ?.filterIsInstance<String>()
                ?: emptyList()

            val weekdays = (data["weekdays"] as? List<*>)
                ?.mapNotNull { (it as? Number)?.toInt() }
                ?: emptyList()

            val scheduleDate = (data["scheduleDate"] as? Number)?.toLong()

            // Only validate weekdays for recurring schedules (when scheduleDate is null)
            if (scheduleDate == null) {
                for (day in weekdays) {
                    if (day !in 1..7) {
                        throw IllegalArgumentException(
                            "Weekday must be an ISO 8601 value between 1 (Monday) and 7 (Sunday), got: $day"
                        )
                    }
                }
            }

            return ScheduleData(
                id = data["id"] as String,
                name = data["name"] as? String ?: "",
                appIdentifiers = appIdentifiers,
                weekdays = weekdays,
                startHour = (data["startHour"] as Number).toInt(),
                startMinute = (data["startMinute"] as Number).toInt(),
                endHour = (data["endHour"] as Number).toInt(),
                endMinute = (data["endMinute"] as Number).toInt(),
                enabled = data["enabled"] as? Boolean ?: true,
                scheduleDate = scheduleDate,
            )
        }
    }
}

/**
 * Creates, updates, removes, and alarms-manages time-based blocking schedules.
 *
 * Schedules are persisted as a JSON array in [BlockerPreferences]. When a
 * schedule is enabled, [registerAlarms] programs [AlarmManager] to fire
 * [ScheduleAlarmReceiver] at the start and end times for each configured
 * weekday. Alarms are exact (`setExactAndAllowWhileIdle`) so they fire even
 * in Doze mode.
 */
class ScheduleManager(private val context: Context) {

    companion object {
        private const val PREFS_KEY_SCHEDULES = "schedules"

        const val ACTION_SCHEDULE_START = "com.khanhtq.app_blocker.SCHEDULE_START"
        const val ACTION_SCHEDULE_END = "com.khanhtq.app_blocker.SCHEDULE_END"
        const val EXTRA_SCHEDULE_ID = "schedule_id"
        const val EXTRA_APP_IDENTIFIERS = "app_identifiers"

        /**
         * Returns true if [currentMinutes] falls within the time range.
         * Handles overnight schedules (e.g., 22:00 → 6:00) correctly.
         */
        internal fun isTimeInRange(currentMinutes: Int, startMinutes: Int, endMinutes: Int): Boolean {
            return if (startMinutes <= endMinutes) {
                // Same-day schedule (e.g., 09:00 → 17:00)
                currentMinutes in startMinutes until endMinutes
            } else {
                // Overnight schedule (e.g., 22:00 → 06:00)
                currentMinutes >= startMinutes || currentMinutes < endMinutes
            }
        }

        // Request-code bases used to generate unique alarm request codes per
        // schedule+weekday+start/end combination.
        private const val REQUEST_CODE_START_BASE = 10_000
        private const val REQUEST_CODE_END_BASE = 20_000
        private const val REQUEST_CODE_ONETIME_BASE = 500_000 // keep one-time range disjoint from recurring ranges
        private const val MAX_WEEKDAYS = 7
    }

    private val alarmManager: AlarmManager =
        context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
    private val preferences = BlockerPreferences(context)
    private val gson = Gson()
    private val blockingServiceManager = BlockingServiceManager(context)

    // ------------------------------------------------------------------
    // CRUD
    // ------------------------------------------------------------------

    /** Persists [data] as a new schedule and registers its alarms if enabled. */
    fun addSchedule(data: Map<String, Any?>) {
        val schedule = ScheduleData.fromMap(data)
        val schedules = loadSchedules().toMutableList()
        schedules.add(schedule)
        saveSchedules(schedules)
        if (schedule.enabled) {
            registerAlarms(schedule)
            if (isCurrentlyActive(schedule)) blockingServiceManager.startBlocking(schedule.appIdentifiers)
        }
    }

    /** Replaces the schedule with the same id and refreshes its alarms. */
    fun updateSchedule(data: Map<String, Any?>) {
        val updated = ScheduleData.fromMap(data)
        val schedules = loadSchedules().toMutableList()
        val index = schedules.indexOfFirst { it.id == updated.id }
        if (index < 0) return

        cancelAlarms(schedules[index].id)
        schedules[index] = updated
        saveSchedules(schedules)
        if (updated.enabled) {
            registerAlarms(updated)
            if (isCurrentlyActive(updated)) blockingServiceManager.startBlocking(updated.appIdentifiers)
        }
    }

    /** Removes the schedule with [id] and cancels its alarms. */
    fun removeSchedule(id: String) {
        val schedules = loadSchedules().toMutableList()
        val schedule = schedules.find { it.id == id } ?: return

        // Cancel alarms and unblock apps if schedule is currently active
        cancelAlarms(id)
        if (schedule.enabled && isCurrentlyActive(schedule)) {
            blockingServiceManager.stopBlockingApps(schedule.appIdentifiers)
        }

        schedules.removeAll { it.id == id }
        saveSchedules(schedules)
    }

    /** Returns all schedules as wire-format maps. */
    fun getSchedules(): List<Map<String, Any?>> = loadSchedules().map { it.toMap() }

    /** Returns the schedule with [id], or null if not found. */
    fun findSchedule(id: String): ScheduleData? = loadSchedules().find { it.id == id }

    /** Returns the union of app identifiers from all enabled schedules that are currently within their active window. */
    fun getActivelyBlockedApps(): Set<String> =
        loadSchedules()
            .filter { it.enabled && isCurrentlyActive(it) }
            .flatMap { it.appIdentifiers }
            .toSet()

    /** Enables the schedule with [id] and registers its alarms. */
    fun enableSchedule(id: String) {
        updateEnabledState(id, enabled = true)
    }

    /** Disables the schedule with [id] and cancels its alarms. */
    fun disableSchedule(id: String) {
        updateEnabledState(id, enabled = false)
    }

    /** Disables all schedules and cancels all their alarms. Does not remove schedules from storage. */
    fun disableAll() {
        val schedules = loadSchedules()
        for (schedule in schedules) {
            cancelAlarms(schedule.id)
        }
        saveSchedules(schedules.map { it.copy(enabled = false) })
    }

    /** Re-registers alarms for all enabled schedules and activates any that are currently active. Called on device boot and plugin attach. */
    fun rescheduleAll() {
        val schedules = loadSchedules()
        val expiredIds = mutableSetOf<String>()

        for (schedule in schedules) {
            if (!schedule.enabled) continue

            if (isOneTimeSchedule(schedule)) {
                val endTime = nextOneTimeAlarmTimeMillis(schedule.scheduleDate!!, schedule.endHour, schedule.endMinute)
                if (endTime == 0L) {
                    expiredIds.add(schedule.id)
                    continue
                }
                // endTime > 0: schedule is still valid (end is in the future).
                // If start is also in the past we're mid-window; isCurrentlyActive handles activation below.
            }

            registerAlarms(schedule)
            if (isCurrentlyActive(schedule)) blockingServiceManager.startBlocking(schedule.appIdentifiers)
        }

        if (expiredIds.isNotEmpty()) {
            saveSchedules(schedules.filterNot { it.id in expiredIds })
            for (id in expiredIds) cancelAlarms(id)
        }
    }

    // ------------------------------------------------------------------
    // Alarm management
    // ------------------------------------------------------------------

    /** Returns true if [schedule] is a one-time schedule (has a specific date). */
    private fun isOneTimeSchedule(schedule: ScheduleData): Boolean = schedule.scheduleDate != null

    private fun registerAlarms(schedule: ScheduleData) {
        if (isOneTimeSchedule(schedule)) {
            registerOneTimeAlarms(schedule)
        } else {
            registerRecurringAlarms(schedule)
        }
    }

    private fun registerRecurringAlarms(schedule: ScheduleData) {
        for (weekday in schedule.weekdays) {
            val startMillis = nextAlarmTimeMillis(weekday, schedule.startHour, schedule.startMinute)
            val endMillis = nextAlarmTimeMillis(weekday, schedule.endHour, schedule.endMinute)

            scheduleExactAlarm(
                action = ACTION_SCHEDULE_START,
                scheduleId = schedule.id,
                appIdentifiers = schedule.appIdentifiers,
                requestCode = requestCode(schedule.id, weekday, isStart = true),
                triggerAtMillis = startMillis,
            )
            scheduleExactAlarm(
                action = ACTION_SCHEDULE_END,
                scheduleId = schedule.id,
                appIdentifiers = schedule.appIdentifiers,
                requestCode = requestCode(schedule.id, weekday, isStart = false),
                triggerAtMillis = endMillis,
            )
        }
    }

    private fun registerOneTimeAlarms(schedule: ScheduleData) {
        val scheduleDate = schedule.scheduleDate ?: return

        val startMillis = nextOneTimeAlarmTimeMillis(scheduleDate, schedule.startHour, schedule.startMinute)
        val endMillis = nextOneTimeAlarmTimeMillis(scheduleDate, schedule.endHour, schedule.endMinute)

        // Only schedule alarms if they are in the future
        if (startMillis > 0) {
            scheduleExactAlarm(
                action = ACTION_SCHEDULE_START,
                scheduleId = schedule.id,
                appIdentifiers = schedule.appIdentifiers,
                requestCode = oneTimeRequestCode(schedule.id, isStart = true),
                triggerAtMillis = startMillis,
            )
        }

        if (endMillis > 0) {
            scheduleExactAlarm(
                action = ACTION_SCHEDULE_END,
                scheduleId = schedule.id,
                appIdentifiers = schedule.appIdentifiers,
                requestCode = oneTimeRequestCode(schedule.id, isStart = false),
                triggerAtMillis = endMillis,
            )
        }
    }

    private fun cancelAlarms(scheduleId: String) {
        for (weekday in 1..MAX_WEEKDAYS) {
            cancelAlarm(ACTION_SCHEDULE_START, scheduleId, emptyList(), requestCode(scheduleId, weekday, isStart = true))
            cancelAlarm(ACTION_SCHEDULE_END, scheduleId, emptyList(), requestCode(scheduleId, weekday, isStart = false))
        }
        cancelAlarm(ACTION_SCHEDULE_START, scheduleId, emptyList(), oneTimeRequestCode(scheduleId, isStart = true))
        cancelAlarm(ACTION_SCHEDULE_END, scheduleId, emptyList(), oneTimeRequestCode(scheduleId, isStart = false))
    }

    private fun scheduleExactAlarm(
        action: String,
        scheduleId: String,
        appIdentifiers: List<String>,
        requestCode: Int,
        triggerAtMillis: Long,
    ) {
        val pending = buildPendingIntent(action, scheduleId, appIdentifiers, requestCode)
        alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, triggerAtMillis, pending)
    }

    private fun cancelAlarm(
        action: String,
        scheduleId: String,
        appIdentifiers: List<String>,
        requestCode: Int,
    ) {
        alarmManager.cancel(buildPendingIntent(action, scheduleId, appIdentifiers, requestCode))
    }

    private fun buildPendingIntent(
        action: String,
        scheduleId: String,
        appIdentifiers: List<String>,
        requestCode: Int,
    ): PendingIntent {
        val intent = Intent(context, ScheduleAlarmReceiver::class.java).apply {
            this.action = action
            putExtra(EXTRA_SCHEDULE_ID, scheduleId)
            putStringArrayListExtra(EXTRA_APP_IDENTIFIERS, ArrayList(appIdentifiers))
        }
        val flags = PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        return PendingIntent.getBroadcast(context, requestCode, intent, flags)
    }

    // ------------------------------------------------------------------
    // Private helpers
    // ------------------------------------------------------------------

    /**
     * Returns true if [schedule] has a window that covers the current day and time.
     */
    private fun isCurrentlyActive(schedule: ScheduleData): Boolean {
        val now = Calendar.getInstance()
        val nowMinutes = now.get(Calendar.HOUR_OF_DAY) * 60 + now.get(Calendar.MINUTE)
        val startMinutes = schedule.startHour * 60 + schedule.startMinute
        val endMinutes = schedule.endHour * 60 + schedule.endMinute

        return if (isOneTimeSchedule(schedule)) {
            // Check if today matches the schedule date
            val scheduleDate = Calendar.getInstance().apply {
                timeInMillis = schedule.scheduleDate!!
            }

            val sameDay = now.get(Calendar.YEAR) == scheduleDate.get(Calendar.YEAR) &&
                          now.get(Calendar.DAY_OF_YEAR) == scheduleDate.get(Calendar.DAY_OF_YEAR)

            sameDay && isTimeInRange(nowMinutes, startMinutes, endMinutes)
        } else {
            // Recurring schedule: check weekdays
            val isoToCalendar = mapOf(1 to 2, 2 to 3, 3 to 4, 4 to 5, 5 to 6, 6 to 7, 7 to 1)
            val todayDow = now.get(Calendar.DAY_OF_WEEK)

            schedule.weekdays.any { weekday ->
                isoToCalendar[weekday] == todayDow && isTimeInRange(nowMinutes, startMinutes, endMinutes)
            }
        }
    }

    private fun updateEnabledState(id: String, enabled: Boolean) {
        val schedules = loadSchedules().toMutableList()
        val index = schedules.indexOfFirst { it.id == id }
        if (index < 0) return

        schedules[index] = schedules[index].copy(enabled = enabled)
        saveSchedules(schedules)

        if (enabled) {
            registerAlarms(schedules[index])
            if (isCurrentlyActive(schedules[index])) blockingServiceManager.startBlocking(schedules[index].appIdentifiers)
        } else {
            cancelAlarms(id)
            if (isCurrentlyActive(schedules[index])) blockingServiceManager.stopBlockingApps(schedules[index].appIdentifiers)
        }
    }

    /**
     * Calculates the next future [Calendar] time for the given [weekday] (ISO 8601)
     * and time of day. If the time has already passed today (or is now), it moves
     * to the same time in the following week.
     */
    private fun nextAlarmTimeMillis(weekday: Int, hour: Int, minute: Int): Long {
        val cal = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)

            // Calendar.DAY_OF_WEEK uses 1=Sunday…7=Saturday;
            // weekday parameter uses ISO 8601 (1=Monday…7=Sunday).
            val isoToCalendar = mapOf(1 to 2, 2 to 3, 3 to 4, 4 to 5, 5 to 6, 6 to 7, 7 to 1)
            val targetDow = isoToCalendar[weekday] ?: return@apply

            var daysAhead = targetDow - get(Calendar.DAY_OF_WEEK)
            if (daysAhead < 0 || (daysAhead == 0 && timeInMillis <= System.currentTimeMillis())) {
                daysAhead += 7
            }
            add(Calendar.DAY_OF_MONTH, daysAhead)
        }
        return cal.timeInMillis
    }

    /**
     * Calculates the alarm time for a one-time schedule on a specific date.
     * Returns 0 if the calculated time is in the past.
     */
    private fun nextOneTimeAlarmTimeMillis(scheduleDateMillis: Long, hour: Int, minute: Int): Long {
        val cal = Calendar.getInstance().apply {
            timeInMillis = scheduleDateMillis
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }

        val alarmTime = cal.timeInMillis
        return if (alarmTime > System.currentTimeMillis()) alarmTime else 0
    }

    /**
     * Generates a unique [PendingIntent] request code for a schedule+weekday+start/end
     * combination. Uses the lower 15 bits of the schedule id's hash to avoid
     * collisions with other intents.
     */
    private fun requestCode(scheduleId: String, weekday: Int, isStart: Boolean): Int {
        val base = if (isStart) REQUEST_CODE_START_BASE else REQUEST_CODE_END_BASE
        return base + (scheduleId.hashCode() and 0x7FFF) * MAX_WEEKDAYS * 2 + weekday
    }

    /**
     * Generates a unique request code for one-time schedules.
     */
    private fun oneTimeRequestCode(scheduleId: String, isStart: Boolean): Int {
        val offset = if (isStart) 0 else 1
        return REQUEST_CODE_ONETIME_BASE + (scheduleId.hashCode() and 0x7FFF) * 2 + offset
    }

    private fun loadSchedules(): List<ScheduleData> {
        val json = preferences.getString(PREFS_KEY_SCHEDULES, null) ?: return emptyList()
        val type = object : TypeToken<List<ScheduleData>>() {}.type
        return try {
            gson.fromJson(json, type) ?: emptyList()
        } catch (_: Exception) {
            emptyList()
        }
    }

    private fun saveSchedules(schedules: List<ScheduleData>) {
        preferences.putString(PREFS_KEY_SCHEDULES, gson.toJson(schedules))
    }
}
