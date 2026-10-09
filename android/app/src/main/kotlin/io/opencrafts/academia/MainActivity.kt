package io.opencrafts.academia

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import com.ryanheise.audioservice.AudioServiceFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : AudioServiceFragmentActivity() {
    private lateinit var pomodoroChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        pomodoroChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            POMODORO_CHANNEL,
        )
        pomodoroChannel.setMethodCallHandler(::handlePomodoroStatusCall)
    }

    private fun handlePomodoroStatusCall(
        call: MethodCall,
        result: MethodChannel.Result,
    ) {
        when (call.method) {
            "start", "update" -> {
                val arguments = call.arguments as? Map<*, *>
                if (arguments == null) {
                    result.error("invalid_arguments", "Timer status arguments are required.", null)
                    return
                }
                val sessionId = arguments["sessionId"] as? String
                val phase = arguments["phase"] as? String
                if (sessionId.isNullOrBlank() || phase.isNullOrBlank()) {
                    result.error("invalid_arguments", "A session and phase are required.", null)
                    return
                }

                val remainingSeconds = (arguments["remainingSeconds"] as? Number)
                    ?.toInt()
                    ?.coerceAtLeast(0)
                    ?: 0
                val endsAtEpochMillis = (arguments["endAtEpochMillis"] as? Number)
                    ?.toLong()
                val isRunning = arguments["isRunning"] as? Boolean ?: false
                val todoTitle = (arguments["todoTitle"] as? String)
                    ?.trim()
                    ?.takeIf { it.isNotEmpty() }

                showPomodoroNotification(
                    sessionId = sessionId,
                    phase = phase,
                    remainingSeconds = remainingSeconds,
                    endsAtEpochMillis = endsAtEpochMillis,
                    isRunning = isRunning,
                    todoTitle = todoTitle,
                )
                result.success(null)
            }

            "stop" -> {
                val sessionId = (call.arguments as? Map<*, *>)?.get("sessionId") as? String
                if (sessionId != null) stopPomodoroNotification(sessionId)
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    private fun showPomodoroNotification(
        sessionId: String,
        phase: String,
        remainingSeconds: Int,
        endsAtEpochMillis: Long?,
        isRunning: Boolean,
        todoTitle: String?,
    ) {
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (!manager.areNotificationsEnabled()) return

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            manager.createNotificationChannel(
                NotificationChannel(
                    POMODORO_NOTIFICATION_CHANNEL,
                    "Pomodoro timer",
                    NotificationManager.IMPORTANCE_DEFAULT,
                ).apply {
                    description = "Shows the current Pomodoro phase and countdown."
                    setSound(null, null)
                    enableVibration(false)
                    enableLights(false)
                    setShowBadge(false)
                    lockscreenVisibility = Notification.VISIBILITY_PRIVATE
                },
            )
        }

        getSharedPreferences(POMODORO_PREFERENCES, Context.MODE_PRIVATE)
            .edit()
            .putString(POMODORO_SESSION_KEY, sessionId)
            .apply()

        val phaseLabel = when (phase) {
            "focus" -> "Focus session"
            "shortBreak" -> "Short break"
            "longBreak" -> "Long break"
            else -> "Pomodoro timer"
        }
        val remainingLabel = formatDuration(remainingSeconds)
        val contentText = when {
            isRunning -> todoTitle ?: "Pomodoro timer"
            todoTitle != null -> "$todoTitle · Paused · $remainingLabel remaining"
            else -> "Paused · $remainingLabel remaining"
        }
        val contentIntent = PendingIntent.getActivity(
            this,
            0,
            packageManager.getLaunchIntentForPackage(packageName)
                ?: Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val builder = Notification.Builder(this, POMODORO_NOTIFICATION_CHANNEL)
            .setSmallIcon(R.drawable.ic_pomodoro_notification)
            .setColor(pomodoroColorForPhase(phase))
            .setContentTitle(phaseLabel)
            .setContentText(contentText)
            .setContentIntent(contentIntent)
            .setCategory(Notification.CATEGORY_PROGRESS)
            .setVisibility(Notification.VISIBILITY_PRIVATE)
            .setOngoing(true)
            .setAutoCancel(false)
            .setOnlyAlertOnce(true)

        if (isRunning) {
            builder
                .setWhen(
                    endsAtEpochMillis
                        ?: System.currentTimeMillis() + remainingSeconds * 1000L,
                )
                .setShowWhen(true)
                .setUsesChronometer(true)
                .setChronometerCountDown(true)
        } else {
            builder.setShowWhen(false)
        }

        manager.notify(POMODORO_NOTIFICATION_ID, builder.build())
    }

    private fun pomodoroColorForPhase(phase: String): Int = when (phase) {
        "focus" -> Color.rgb(103, 80, 164)
        "shortBreak" -> Color.rgb(0, 107, 94)
        "longBreak" -> Color.rgb(56, 106, 32)
        else -> Color.rgb(73, 69, 79)
    }

    private fun formatDuration(seconds: Int): String {
        val minutes = seconds / 60
        val remainder = seconds % 60
        return "%02d:%02d".format(minutes, remainder)
    }

    private fun stopPomodoroNotification(sessionId: String) {
        val preferences = getSharedPreferences(POMODORO_PREFERENCES, Context.MODE_PRIVATE)
        if (preferences.getString(POMODORO_SESSION_KEY, null) != sessionId) return
        (getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager)
            .cancel(POMODORO_NOTIFICATION_ID)
        preferences.edit().remove(POMODORO_SESSION_KEY).apply()
    }

    private companion object {
        const val POMODORO_CHANNEL = "io.opencrafts.academia/pomodoro_status"
        const val POMODORO_NOTIFICATION_CHANNEL = "pomodoro_timer_v2"
        const val POMODORO_NOTIFICATION_ID = 7521
        const val POMODORO_PREFERENCES = "pomodoro_status"
        const val POMODORO_SESSION_KEY = "session_id"
    }
}
