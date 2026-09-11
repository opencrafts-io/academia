package com.khanhtq.app_blocker.scheduling

import android.content.Context
import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import com.google.gson.reflect.TypeToken
import com.khanhtq.app_blocker.blocking.BlockingServiceManager
import com.khanhtq.app_blocker.event.BlockEventStreamHandler
import com.khanhtq.app_blocker.persistence.BlockerPreferences

/**
 * Represents a blocking profile — a named group of apps and optional schedules
 * that can be activated/deactivated atomically.
 */
data class ProfileData(
    @SerializedName("id") val id: String,
    @SerializedName("name") val name: String,
    @SerializedName("appIdentifiers") val appIdentifiers: List<String>,
    @SerializedName("schedules") val schedules: List<ScheduleData>,
    @SerializedName("isActive") val isActive: Boolean,
) {
    /** Converts this instance to the map format sent over the Flutter channel. */
    fun toMap(): Map<String, Any?> = mapOf(
        "id" to id,
        "name" to name,
        "appIdentifiers" to appIdentifiers,
        "schedules" to schedules.map { it.toMap() },
        "isActive" to isActive,
    )

    companion object {
        /**
         * Constructs a [ProfileData] from a Flutter channel map.
         *
         * List elements arrive as [List<*>]; [filterIsInstance] recovers type
         * safety without unchecked casts.
         */
        fun fromMap(data: Map<String, Any?>): ProfileData {
            val appIdentifiers = (data["appIdentifiers"] as? List<*>)
                ?.filterIsInstance<String>()
                ?: emptyList()

            val schedules = (data["schedules"] as? List<*>)
                ?.filterIsInstance<Map<String, Any?>>()
                ?.map { ScheduleData.fromMap(it) }
                ?: emptyList()

            return ProfileData(
                id = data["id"] as String,
                name = data["name"] as? String ?: "",
                appIdentifiers = appIdentifiers,
                schedules = schedules,
                isActive = data["isActive"] as? Boolean ?: false,
            )
        }
    }
}

/**
 * Creates, updates, deletes, and activates/deactivates blocking profiles.
 *
 * Profiles are persisted as a JSON array in [BlockerPreferences]. Activating
 * a profile:
 * 1. Deactivates any currently active profile.
 * 2. Starts blocking the profile's apps via [BlockingServiceManager].
 * 3. Registers each of the profile's nested schedules via [ScheduleManager].
 *
 * Deactivating reverses steps 2–3.
 */
class ProfileManager(private val context: Context) {

    companion object {
        private const val PREFS_KEY_PROFILES = "profiles"
    }

    private val preferences = BlockerPreferences(context)
    private val gson = Gson()
    private val scheduleManager = ScheduleManager(context)
    private val blockingServiceManager = BlockingServiceManager(context)

    // ------------------------------------------------------------------
    // CRUD
    // ------------------------------------------------------------------

    /** Persists [data] as a new profile. */
    fun createProfile(data: Map<String, Any?>) {
        val profile = ProfileData.fromMap(data)
        val profiles = loadProfiles().toMutableList()
        profiles.add(profile)
        saveProfiles(profiles)
    }

    /** Replaces the profile with the same id. */
    fun updateProfile(data: Map<String, Any?>) {
        val updated = ProfileData.fromMap(data)
        val profiles = loadProfiles().toMutableList()
        val index = profiles.indexOfFirst { it.id == updated.id }
        if (index < 0) return

        profiles[index] = updated
        saveProfiles(profiles)
    }

    /** Deletes the profile with [id], deactivating it first if necessary. */
    fun deleteProfile(id: String) {
        val profiles = loadProfiles().toMutableList()
        val profile = profiles.find { it.id == id } ?: return

        if (profile.isActive) deactivateInternal(profile)
        profiles.removeAll { it.id == id }
        saveProfiles(profiles)
    }

    /** Returns all profiles as wire-format maps. */
    fun getProfiles(): List<Map<String, Any?>> = loadProfiles().map { it.toMap() }

    // ------------------------------------------------------------------
    // Activation
    // ------------------------------------------------------------------

    /**
     * Activates the profile with [id].
     *
     * @throws IllegalArgumentException if no profile with [id] exists.
     */
    fun activateProfile(id: String) {
        val profiles = loadProfiles().toMutableList()

        // Deactivate any currently active profile.
        val activeIndex = profiles.indexOfFirst { it.isActive }
        if (activeIndex >= 0) {
            deactivateInternal(profiles[activeIndex])
            profiles[activeIndex] = profiles[activeIndex].copy(isActive = false)
        }

        val targetIndex = profiles.indexOfFirst { it.id == id }
        if (targetIndex < 0) throw IllegalArgumentException("Profile '$id' not found.")

        val target = profiles[targetIndex].copy(isActive = true)
        profiles[targetIndex] = target
        saveProfiles(profiles)

        // Block the profile's apps.
        blockingServiceManager.startBlocking(target.appIdentifiers)

        // Register each embedded schedule.
        for (schedule in target.schedules) {
            scheduleManager.addSchedule(schedule.copy(enabled = true).toMap())
        }

        BlockEventStreamHandler.sendEvent(
            mapOf(
                "type" to "profileActivated",
                "profileId" to id,
                "timestamp" to System.currentTimeMillis(),
            )
        )
    }

    /** Deactivates the currently active profile. Returns `true` if one was active. */
    fun deactivateActiveProfile(): Boolean {
        val activeId = loadProfiles().find { it.isActive }?.id ?: return false
        deactivateProfile(activeId)
        return true
    }

    /** Deactivates the profile with [id]. No-op if it is not active. */
    fun deactivateProfile(id: String) {
        val profiles = loadProfiles().toMutableList()
        val index = profiles.indexOfFirst { it.id == id }
        if (index < 0) return

        deactivateInternal(profiles[index])
        profiles[index] = profiles[index].copy(isActive = false)
        saveProfiles(profiles)
    }

    /** Returns the active profile as a wire-format map, or `null`. */
    fun getActiveProfile(): Map<String, Any?>? =
        loadProfiles().find { it.isActive }?.toMap()

    // ------------------------------------------------------------------
    // Private helpers
    // ------------------------------------------------------------------

    /**
     * Stops blocking the [profile]'s apps and removes its schedules.
     * Does **not** write to storage — callers handle persistence.
     */
    private fun deactivateInternal(profile: ProfileData) {
        // Emit individual unblocked events for each app before stopping blocking
        val timestamp = System.currentTimeMillis()
        for (packageName in profile.appIdentifiers) {
            BlockEventStreamHandler.sendEvent(
                mapOf(
                    "type" to "unblocked",
                    "packageName" to packageName,
                    "timestamp" to timestamp,
                )
            )
        }

        blockingServiceManager.stopBlockingApps(profile.appIdentifiers)
        for (schedule in profile.schedules) {
            scheduleManager.removeSchedule(schedule.id)
        }
        BlockEventStreamHandler.sendEvent(
            mapOf(
                "type" to "profileDeactivated",
                "profileId" to profile.id,
                "timestamp" to timestamp,
            )
        )
    }

    private fun loadProfiles(): List<ProfileData> {
        val json = preferences.getString(PREFS_KEY_PROFILES, null) ?: return emptyList()
        val type = object : TypeToken<List<ProfileData>>() {}.type
        return try {
            gson.fromJson(json, type) ?: emptyList()
        } catch (_: Exception) {
            emptyList()
        }
    }

    private fun saveProfiles(profiles: List<ProfileData>) {
        preferences.putString(PREFS_KEY_PROFILES, gson.toJson(profiles))
    }
}
