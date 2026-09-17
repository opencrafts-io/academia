package com.khanhtq.app_blocker.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.khanhtq.app_blocker.scheduling.ScheduleManager

/**
 * Restores schedule alarms after a device reboot.
 *
 * The blocking state itself (which apps are blocked) is persisted in
 * [com.khanhtq.app_blocker.persistence.BlockerPreferences] and read by
 * [com.khanhtq.app_blocker.blocking.AppBlockerAccessibilityService] on every
 * window-change event — no additional restoration step is needed for that.
 *
 * AlarmManager alarms, however, are cleared on reboot and must be rescheduled
 * explicitly.
 */
class BootReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Intent.ACTION_BOOT_COMPLETED) return
        ScheduleManager(context).rescheduleAll()
    }
}
