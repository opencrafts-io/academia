package com.khanhtq.app_blocker

import android.app.Activity
import android.content.Context
import com.khanhtq.app_blocker.blocking.BlockingServiceManager
import com.khanhtq.app_blocker.event.BlockEventStreamHandler
import com.khanhtq.app_blocker.persistence.BlockerPreferences
import com.khanhtq.app_blocker.scheduling.ProfileManager
import com.khanhtq.app_blocker.scheduling.ScheduleManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/**
 * Flutter plugin entry-point for app_blocker.
 *
 * Wires the Dart method/event channels to the native Android managers.
 * All method calls that may block are dispatched to [Dispatchers.Default]
 * and the result is posted back on the main thread.
 */
class AppBlockerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    companion object {
        // Channel names — must match Dart AppBlockerConstants exactly.
        private const val METHOD_CHANNEL = "com.khanhtq.app_blocker/methods"
        private const val EVENT_CHANNEL = "com.khanhtq.app_blocker/events"

        // Method names.
        private const val GET_CAPABILITIES = "getCapabilities"
        private const val CHECK_PERMISSION = "checkPermission"
        private const val REQUEST_PERMISSION = "requestPermission"
        private const val GET_APPS = "getApps"
        private const val BLOCK_APPS = "blockApps"
        private const val BLOCK_ALL = "blockAll"
        private const val UNBLOCK_APPS = "unblockApps"
        private const val UNBLOCK_ALL = "unblockAll"
        private const val GET_BLOCKED_APPS = "getBlockedApps"
        private const val GET_APP_STATUS = "getAppStatus"
        private const val SET_BLOCK_SCREEN_CONFIG = "setBlockScreenConfig"
        private const val GET_BLOCK_SCREEN_CONFIG = "getBlockScreenConfig"
        private const val ADD_SCHEDULE = "addSchedule"
        private const val UPDATE_SCHEDULE = "updateSchedule"
        private const val REMOVE_SCHEDULE = "removeSchedule"
        private const val GET_SCHEDULES = "getSchedules"
        private const val ENABLE_SCHEDULE = "enableSchedule"
        private const val DISABLE_SCHEDULE = "disableSchedule"
        private const val CREATE_PROFILE = "createProfile"
        private const val UPDATE_PROFILE = "updateProfile"
        private const val DELETE_PROFILE = "deleteProfile"
        private const val GET_PROFILES = "getProfiles"
        private const val ACTIVATE_PROFILE = "activateProfile"
        private const val DEACTIVATE_PROFILE = "deactivateProfile"
        private const val GET_ACTIVE_PROFILE = "getActiveProfile"

        // Error codes — must match Dart AppBlockerConstants exactly.
        const val ERROR_PERMISSION_DENIED = "PERMISSION_DENIED"
        const val ERROR_SERVICE_UNAVAILABLE = "SERVICE_UNAVAILABLE"
        const val ERROR_SCHEDULE_CONFLICT = "SCHEDULE_CONFLICT"
        const val ERROR_PROFILE_NOT_FOUND = "PROFILE_NOT_FOUND"
        const val ERROR_INVALID_CONFIG = "INVALID_CONFIG"
    }

    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var context: Context
    private var activity: Activity? = null

    private lateinit var permissionManager: PermissionManager
    private lateinit var appResolver: AppResolver
    private lateinit var blockingServiceManager: BlockingServiceManager
    private lateinit var scheduleManager: ScheduleManager
    private lateinit var profileManager: ProfileManager
    private lateinit var preferences: BlockerPreferences

    // Coroutine scope bound to the plugin lifecycle.
    private val job = Job()
    private val scope = CoroutineScope(Dispatchers.Default + job)

    // ------------------------------------------------------------------
    // FlutterPlugin
    // ------------------------------------------------------------------

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        preferences = BlockerPreferences(context)

        methodChannel = MethodChannel(binding.binaryMessenger, METHOD_CHANNEL)
        methodChannel.setMethodCallHandler(this)

        eventChannel = EventChannel(binding.binaryMessenger, EVENT_CHANNEL)
        eventChannel.setStreamHandler(BlockEventStreamHandler.instance)

        permissionManager = PermissionManager(context)
        appResolver = AppResolver(context)
        blockingServiceManager = BlockingServiceManager(context)
        scheduleManager = ScheduleManager(context)
        profileManager = ProfileManager(context)
        scheduleManager.rescheduleAll()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        job.cancel()
    }

    // ------------------------------------------------------------------
    // ActivityAware
    // ------------------------------------------------------------------

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    // ------------------------------------------------------------------
    // MethodCallHandler
    // ------------------------------------------------------------------

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

            // -- Capabilities --

            GET_CAPABILITIES -> {
                result.success(
                    mapOf(
                        "canBlockApps" to true,
                        "canCustomizeBlockScreen" to true,
                        "canUseSystemShield" to false,
                        "canSchedule" to true,
                        "canGetInstalledApps" to true,
                        "canShowActivityPicker" to false,
                    )
                )
            }

            // -- Permissions --

            CHECK_PERMISSION -> result.success(permissionManager.checkAllPermissions())

            REQUEST_PERMISSION -> {
                val currentActivity = activity ?: run {
                    result.error(ERROR_SERVICE_UNAVAILABLE, "Activity is not available.", null)
                    return
                }
                result.success(permissionManager.requestAllPermissions(currentActivity))
            }

            // -- App Discovery --

            GET_APPS -> {
                scope.launch {
                    try {
                        val apps = appResolver.getInstalledApps()
                        withContext(Dispatchers.Main) { result.success(apps) }
                    } catch (e: Exception) {
                        withContext(Dispatchers.Main) {
                            result.error(ERROR_SERVICE_UNAVAILABLE, e.message, null)
                        }
                    }
                }
            }

            // -- Blocking --

            BLOCK_APPS -> {
                val identifiers = call.argument<List<String>>("identifiers") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'identifiers' argument.", null)
                    return
                }
                try {
                    blockingServiceManager.startBlocking(identifiers)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(ERROR_SERVICE_UNAVAILABLE, e.message, null)
                }
            }

            BLOCK_ALL -> {
                try {
                    blockingServiceManager.startBlockingAll()
                    result.success(null)
                } catch (e: Exception) {
                    result.error(ERROR_SERVICE_UNAVAILABLE, e.message, null)
                }
            }

            UNBLOCK_APPS -> {
                val identifiers = call.argument<List<String>>("identifiers") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'identifiers' argument.", null)
                    return
                }
                blockingServiceManager.stopBlockingApps(identifiers)
                result.success(null)
            }

            UNBLOCK_ALL -> {
                profileManager.deactivateActiveProfile()
                scheduleManager.disableAll()
                blockingServiceManager.stopBlocking()
                result.success(null)
            }

            GET_BLOCKED_APPS -> {
                if (preferences.isBlocking() && preferences.isBlockAll()) {
                    result.success(listOf("__all__"))
                } else {
                    result.success(
                        (blockingServiceManager.getBlockedApps() + scheduleManager.getActivelyBlockedApps()).toList()
                    )
                }
            }

            GET_APP_STATUS -> {
                val identifier = call.argument<String>("identifier") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'identifier' argument.", null)
                    return
                }
                val blocked = blockingServiceManager.getBlockedApps() + scheduleManager.getActivelyBlockedApps()
                val status = when {
                    preferences.isBlocking() && preferences.isBlockAll() -> "blocked"
                    identifier in blocked -> "blocked"
                    else -> "unblocked"
                }
                result.success(status)
            }

            // -- Block Screen Config --

            SET_BLOCK_SCREEN_CONFIG -> {
                val configMap = buildMap<String, Any?> {
                    put("title", call.argument<String>("title"))
                    put("subtitle", call.argument<String>("subtitle"))
                    put("message", call.argument<String>("message"))
                    put("backgroundColor", call.argument<Long>("backgroundColor"))
                    put("iconAssetPath", call.argument<String>("iconAssetPath"))
                }
                preferences.overlayConfig = com.google.gson.Gson().toJson(configMap)
                result.success(null)
            }

            GET_BLOCK_SCREEN_CONFIG -> {
                val json = preferences.overlayConfig
                if (json == "{}") {
                    result.success(null)
                } else {
                    try {
                        val obj = org.json.JSONObject(json)
                        val map = mutableMapOf<String, Any?>()
                        if (obj.has("title") && !obj.isNull("title")) map["title"] = obj.getString("title")
                        if (obj.has("subtitle") && !obj.isNull("subtitle")) map["subtitle"] = obj.getString("subtitle")
                        if (obj.has("message") && !obj.isNull("message")) map["message"] = obj.getString("message")
                        if (obj.has("backgroundColor") && !obj.isNull("backgroundColor")) map["backgroundColor"] = obj.getLong("backgroundColor")
                        if (obj.has("iconAssetPath") && !obj.isNull("iconAssetPath")) map["iconAssetPath"] = obj.getString("iconAssetPath")
                        result.success(map)
                    } catch (_: Exception) {
                        result.success(null)
                    }
                }
            }

            // -- Scheduling --

            ADD_SCHEDULE -> {
                // Method channel guarantees Map<String, Any?> for object arguments.
                val scheduleMap = requireMapArgument(call, result) ?: return
                try {
                    scheduleManager.addSchedule(scheduleMap)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(ERROR_SCHEDULE_CONFLICT, e.message, null)
                }
            }

            UPDATE_SCHEDULE -> {
                val scheduleMap = requireMapArgument(call, result) ?: return
                try {
                    scheduleManager.updateSchedule(scheduleMap)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(ERROR_SCHEDULE_CONFLICT, e.message, null)
                }
            }

            REMOVE_SCHEDULE -> {
                val id = call.argument<String>("id") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'id' argument.", null)
                    return
                }
                scheduleManager.removeSchedule(id)
                result.success(null)
            }

            GET_SCHEDULES -> result.success(scheduleManager.getSchedules())

            ENABLE_SCHEDULE -> {
                val id = call.argument<String>("id") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'id' argument.", null)
                    return
                }
                scheduleManager.enableSchedule(id)
                result.success(null)
            }

            DISABLE_SCHEDULE -> {
                val id = call.argument<String>("id") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'id' argument.", null)
                    return
                }
                scheduleManager.disableSchedule(id)
                result.success(null)
            }

            // -- Profiles --

            CREATE_PROFILE -> {
                val profileMap = requireMapArgument(call, result) ?: return
                try {
                    profileManager.createProfile(profileMap)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(ERROR_INVALID_CONFIG, e.message, null)
                }
            }

            UPDATE_PROFILE -> {
                val profileMap = requireMapArgument(call, result) ?: return
                try {
                    profileManager.updateProfile(profileMap)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(ERROR_PROFILE_NOT_FOUND, e.message, null)
                }
            }

            DELETE_PROFILE -> {
                val id = call.argument<String>("id") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'id' argument.", null)
                    return
                }
                profileManager.deleteProfile(id)
                result.success(null)
            }

            GET_PROFILES -> result.success(profileManager.getProfiles())

            ACTIVATE_PROFILE -> {
                val id = call.argument<String>("id") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'id' argument.", null)
                    return
                }
                try {
                    profileManager.activateProfile(id)
                    result.success(null)
                } catch (e: Exception) {
                    result.error(ERROR_PROFILE_NOT_FOUND, e.message, null)
                }
            }

            DEACTIVATE_PROFILE -> {
                val id = call.argument<String>("id") ?: run {
                    result.error(ERROR_INVALID_CONFIG, "Missing 'id' argument.", null)
                    return
                }
                profileManager.deactivateProfile(id)
                result.success(null)
            }

            GET_ACTIVE_PROFILE -> result.success(profileManager.getActiveProfile())

            else -> result.notImplemented()
        }
    }

    // ------------------------------------------------------------------
    // Helpers
    // ------------------------------------------------------------------

    /**
     * Extracts [MethodCall.arguments] as `Map<String, Any?>`, sending an
     * [ERROR_INVALID_CONFIG] error and returning `null` if the arguments
     * are not a map.
     *
     * Flutter's method channel guarantees that object arguments arrive as
     * `Map<String, Any?>` when sent from Dart as a `Map<String, dynamic>`.
     * The unchecked cast is therefore safe; the suppress is intentional.
     */
    private fun requireMapArgument(call: MethodCall, result: Result): Map<String, Any?>? {
        val raw = call.arguments
        if (raw !is Map<*, *>) {
            result.error(ERROR_INVALID_CONFIG, "Expected a map argument for '${call.method}'.", null)
            return null
        }
        @Suppress("UNCHECKED_CAST") // Safe: Flutter channel always uses String keys with Any? values
        return raw as Map<String, Any?>
    }
}
