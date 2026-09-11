package com.khanhtq.app_blocker.event

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel

/**
 * Singleton [EventChannel.StreamHandler] that delivers block events to Flutter.
 *
 * Any component — including [com.khanhtq.app_blocker.blocking.AppBlockerAccessibilityService]
 * and the scheduling receivers — can call [sendEvent] from any thread. Events
 * are always posted to the main looper before being forwarded to the Flutter
 * engine, which is the only thread on which [EventChannel.EventSink.success]
 * may be called safely.
 *
 * ### Calling conventions
 *
 * **Instance-based** (from the plugin, where the instance is readily accessible):
 * ```kotlin
 * BlockEventStreamHandler.instance.sendEvent("blocked", packageName = "com.example.app")
 * ```
 *
 * **Static map-based** (from services and receivers that only have access to
 * the companion object via a static import):
 * ```kotlin
 * BlockEventStreamHandler.sendEvent(
 *     mapOf("type" to "blocked", "packageName" to "com.example.app", "timestamp" to millis)
 * )
 * ```
 */
class BlockEventStreamHandler private constructor() : EventChannel.StreamHandler {

    companion object {
        /** Shared instance registered with the [EventChannel]. */
        val instance: BlockEventStreamHandler by lazy { BlockEventStreamHandler() }

        private val mainHandler = Handler(Looper.getMainLooper())

        /**
         * Posts [event] to the Flutter sink on the main thread.
         * Safe to call from any thread. No-ops if no listener is attached.
         */
        @JvmStatic
        fun sendEvent(event: Map<String, Any?>) {
            // Snapshot the sink reference once to avoid TOCTOU races.
            val sink = instance.eventSink ?: return

            if (Looper.myLooper() == Looper.getMainLooper()) {
                sink.success(event)
            } else {
                mainHandler.post { sink.success(event) }
            }
        }
    }

    /**
     * The active Flutter event sink.
     *
     * Marked [@Volatile] so that reads in [sendEvent] (potentially on a
     * background thread) always observe the most recent write from the main
     * thread inside [onListen] / [onCancel].
     */
    @Volatile
    private var eventSink: EventChannel.EventSink? = null

    // ------------------------------------------------------------------
    // StreamHandler
    // ------------------------------------------------------------------

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    // ------------------------------------------------------------------
    // Instance API
    // ------------------------------------------------------------------

    /**
     * Sends a typed block event to Flutter.
     *
     * @param type        Event type matching Dart's `BlockEventType` values:
     *                    `"blocked"`, `"unblocked"`, `"attemptedAccess"`,
     *                    `"scheduleActivated"`, `"scheduleDeactivated"`.
     * @param packageName Package name of the affected app, or `null`.
     * @param scheduleId  ID of the schedule that triggered the event, or `null`.
     */
    fun sendEvent(type: String, packageName: String? = null, scheduleId: String? = null) {
        sendEvent(
            buildMap {
                put("type", type)
                put("timestamp", System.currentTimeMillis())
                if (packageName != null) put("packageName", packageName)
                if (scheduleId != null) put("scheduleId", scheduleId)
            }
        )
    }
}
