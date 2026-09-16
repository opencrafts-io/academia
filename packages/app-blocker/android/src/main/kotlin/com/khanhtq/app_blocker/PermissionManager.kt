package com.khanhtq.app_blocker

import android.app.Activity
import android.app.AlarmManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import com.khanhtq.app_blocker.blocking.AppBlockerAccessibilityService

/**
 * Checks and requests the permissions required for app blocking:
 *
 * 1. **Accessibility service** — [AppBlockerAccessibilityService] must be enabled
 *    by the user in Settings → Accessibility. This is the core detection mechanism.
 *
 * 2. **Exact alarms (SCHEDULE_EXACT_ALARM)** — required on Android 12+ (API 31+)
 *    to trigger schedule start/end at precise times via [AlarmManager].
 *
 * Both are "special" permissions that cannot be granted at runtime;
 * the user must navigate to system settings. [requestAllPermissions] opens the
 * appropriate settings screen for the first missing permission.
 *
 */
class PermissionManager(private val context: Context) {

    // ------------------------------------------------------------------
    // Aggregate API
    // ------------------------------------------------------------------

    /**
     * Returns the aggregate permission status string:
     * - `"granted"` — accessibility service enabled **and** exact-alarm permission granted.
     * - `"denied"`  — one or more required permissions are missing.
     */
    fun checkAllPermissions(): String {
        val accessibility = checkAccessibilityPermission()
        val exactAlarm = checkExactAlarmPermission()
        return if (accessibility && exactAlarm) "granted" else "denied"
    }

    /**
     * Navigates the user to the settings screen for the first missing permission.
     * Returns the current aggregate status (always `"denied"` when called, since
     * the user hasn't granted the permission yet).
     *
     * @param activity The currently visible [Activity] used to start the settings intent.
     */
    fun requestAllPermissions(activity: Activity): String {
        if (!checkAccessibilityPermission()) {
            requestAccessibilityPermission(activity)
            return "denied"
        }
        if (!checkExactAlarmPermission()) {
            requestExactAlarmPermission(activity)
            return "denied"
        }
        return "granted"
    }

    // ------------------------------------------------------------------
    // Accessibility service permission
    // ------------------------------------------------------------------

    /**
     * Returns `true` if [AppBlockerAccessibilityService] is listed in the
     * system's enabled accessibility services.
     */
    fun checkAccessibilityPermission(): Boolean {
        val enabledServices = Settings.Secure.getString(
            context.contentResolver,
            Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES,
        ) ?: return false

        val component = ComponentName(context, AppBlockerAccessibilityService::class.java)
        val flat = component.flattenToString()

        // The enabled-services string is colon-delimited.
        return TextUtils.SimpleStringSplitter(':').apply { setString(enabledServices) }
            .any { it.equals(flat, ignoreCase = true) }
    }

    /**
     * Opens the system Accessibility settings so the user can enable
     * [AppBlockerAccessibilityService].
     */
    fun requestAccessibilityPermission(activity: Activity) {
        if (!checkAccessibilityPermission()) {
            activity.startActivity(Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS))
        }
    }

    // ------------------------------------------------------------------
    // Exact alarm permission (Android 12+ / API 31+)
    // ------------------------------------------------------------------

    /**
     * Returns `true` if the app can schedule exact alarms.
     * On API < 31 this is always granted via the manifest declaration.
     */
    fun checkExactAlarmPermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
            alarmManager.canScheduleExactAlarms()
        } else {
            true
        }
    }

    /**
     * Opens the "Alarms & reminders" settings screen so the user can grant
     * exact alarm permission (Android 12+ only).
     */
    fun requestExactAlarmPermission(activity: Activity) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && !checkExactAlarmPermission()) {
            activity.startActivity(
                Intent(
                    Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                    android.net.Uri.parse("package:${activity.packageName}"),
                )
            )
        }
    }
}
