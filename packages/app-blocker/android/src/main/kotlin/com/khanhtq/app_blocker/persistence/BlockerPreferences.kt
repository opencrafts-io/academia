package com.khanhtq.app_blocker.persistence

import android.content.Context
import android.content.SharedPreferences

/**
 * Typed wrapper around [SharedPreferences] for all app-blocker data.
 *
 * Preference file: `"app_blocker_prefs"`.
 *
 * Provides both Kotlin-property accessors (used by the plugin) and
 * method-style accessors (used by the blocking service and schedule
 * managers that may run in a different process).
 */
class BlockerPreferences(context: Context) {

    companion object {
        private const val PREF_NAME = "app_blocker_prefs"

        private const val KEY_BLOCKED_APPS = "blocked_apps"
        private const val KEY_IS_BLOCKING = "is_blocking"
        private const val KEY_BLOCK_ALL = "block_all"
        private const val KEY_OVERLAY_CONFIG = "overlay_config"
        private const val KEY_SCHEDULES = "schedules"
        private const val KEY_PROFILES = "profiles"
        private const val KEY_ACTIVE_PROFILE_ID = "active_profile_id"
    }

    private val prefs: SharedPreferences =
        context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)

    // ==================================================================
    // blockedApps — Set<String>
    // ==================================================================

    fun getBlockedApps(): Set<String> =
        prefs.getStringSet(KEY_BLOCKED_APPS, emptySet()) ?: emptySet()

    fun setBlockedApps(value: Set<String>) {
        prefs.edit().putStringSet(KEY_BLOCKED_APPS, value).apply()
    }

    // ==================================================================
    // isBlocking — Boolean
    // ==================================================================

    var isBlockingProp: Boolean
        get() = isBlocking()
        set(value) = setIsBlocking(value)

    fun isBlocking(): Boolean = prefs.getBoolean(KEY_IS_BLOCKING, false)

    fun setIsBlocking(value: Boolean) {
        prefs.edit().putBoolean(KEY_IS_BLOCKING, value).apply()
    }

    // ==================================================================
    // blockAll — Boolean
    // ==================================================================

    var blockAllProp: Boolean
        get() = isBlockAll()
        set(value) = setBlockAll(value)

    fun isBlockAll(): Boolean = prefs.getBoolean(KEY_BLOCK_ALL, false)

    fun setBlockAll(value: Boolean) {
        prefs.edit().putBoolean(KEY_BLOCK_ALL, value).apply()
    }

    // ==================================================================
    // overlayConfig — JSON string (key kept as "overlay_config" for backwards compatibility)
    // ==================================================================

    var overlayConfig: String
        get() = prefs.getString(KEY_OVERLAY_CONFIG, "{}") ?: "{}"
        set(value) {
            prefs.edit().putString(KEY_OVERLAY_CONFIG, value).apply()
        }

    // ==================================================================
    // schedules — JSON array string
    // ==================================================================

    var schedules: String
        get() = prefs.getString(KEY_SCHEDULES, "[]") ?: "[]"
        set(value) {
            prefs.edit().putString(KEY_SCHEDULES, value).apply()
        }

    // ==================================================================
    // profiles — JSON array string
    // ==================================================================

    var profiles: String
        get() = prefs.getString(KEY_PROFILES, "[]") ?: "[]"
        set(value) {
            prefs.edit().putString(KEY_PROFILES, value).apply()
        }

    // ==================================================================
    // activeProfileId — nullable String
    // ==================================================================

    var activeProfileId: String?
        get() = prefs.getString(KEY_ACTIVE_PROFILE_ID, null)
        set(value) {
            if (value == null) {
                prefs.edit().remove(KEY_ACTIVE_PROFILE_ID).apply()
            } else {
                prefs.edit().putString(KEY_ACTIVE_PROFILE_ID, value).apply()
            }
        }

    // ==================================================================
    // Generic accessors — used by ScheduleManager / ProfileManager
    // that store arbitrary JSON blobs under custom keys.
    // ==================================================================

    fun getString(key: String, defValue: String?): String? =
        prefs.getString(key, defValue)

    fun putString(key: String, value: String) {
        prefs.edit().putString(key, value).apply()
    }
}
