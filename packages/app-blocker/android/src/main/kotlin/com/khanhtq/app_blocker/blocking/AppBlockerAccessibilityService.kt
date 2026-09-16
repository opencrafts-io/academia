package com.khanhtq.app_blocker.blocking

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import com.khanhtq.app_blocker.event.BlockEventStreamHandler
import com.khanhtq.app_blocker.persistence.BlockerPreferences

/**
 * Accessibility service that detects foreground app changes and triggers the
 * block screen when a blocked app comes to the foreground.
 *
 * **Battery efficiency:** Reacts to [AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED]
 * events fired by Android exactly when the foreground window changes — zero idle CPU cost.
 *
 * **Block flow (mirrors the digipaws pattern):**
 * 1. Blocked app detected → [performGlobalAction] HOME (sends user away immediately)
 * 2. [lastPackage] reset so the next round of events is processed cleanly
 * 3. After [BLOCK_LAUNCH_DELAY_MS] Academia's Flutter block screen is opened
 *
 * This avoids the ghost-event re-show bugs that plagued the previous overlay approach:
 * - No system overlay that could be spuriously re-triggered after dismissal
 * - Own-package events (from the block Activity) are already filtered, so no
 *   race between "overlay just hidden" and "next blocked-app event"
 *
 * **Setup:** The user must enable this service in Settings → Accessibility → App Blocker.
 */
class AppBlockerAccessibilityService : AccessibilityService() {

    companion object {
        private const val TAG = "AppBlockerService"

        /** Events we care about — window transitions and content changes. */
        private const val TARGET_EVENTS =
            AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED

        /** System packages we never want to block. */
        private const val SYSTEM_UI_PACKAGE = "com.android.systemui"

        /**
         * Delay between pressing HOME and opening Academia's block screen.
         * Gives the home screen time to settle before the deep link is handled.
         */
        private const val BLOCK_LAUNCH_DELAY_MS = 150L

        /**
         * The running service instance, or null if the service is not connected.
         * Used by [BlockingServiceManager] to trigger an immediate block check
         * when blocking state changes (e.g. a schedule activates).
         */
        @Volatile
        var instance: AppBlockerAccessibilityService? = null
            private set
    }

    private lateinit var preferences: BlockerPreferences
    private val handler = Handler(Looper.getMainLooper())

    /**
     * Last package seen in the foreground. Used to skip duplicate events for
     * the same app — the accessibility subsystem fires multiple events per
     * window transition.
     *
     * Reset to `""` whenever blocking is triggered so the next round of
     * events (home screen, then block activity) is processed fresh.
     */
    @Volatile
    private var lastPackage: String = ""

    @Volatile
    private var blockScreenLaunchPending = false

    // ------------------------------------------------------------------
    // Lifecycle
    // ------------------------------------------------------------------

    override fun onServiceConnected() {
        super.onServiceConnected()
        preferences = BlockerPreferences(this)
        instance = this
    }

    override fun onInterrupt() {
        // Required override; nothing to clean up since the Activity manages itself.
    }

    override fun onDestroy() {
        instance = null
        handler.removeCallbacksAndMessages(null)
        super.onDestroy()
    }

    // ------------------------------------------------------------------
    // Immediate block check (called when blocking state changes externally)
    // ------------------------------------------------------------------

    /**
     * Re-evaluates [lastPackage] against the current blocking state.
     * Called by [BlockingServiceManager] after blocking is activated so that
     * an app already in the foreground is blocked immediately without waiting
     * for the next accessibility event (e.g. when a schedule starts).
     */
    fun checkCurrentForegroundApp() {
        val pkg = lastPackage
        if (pkg.isNotEmpty()) {
            checkAndBlock(pkg)
        }
    }

    // ------------------------------------------------------------------
    // Event handling
    // ------------------------------------------------------------------

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return

        val packageName = event.packageName?.toString() ?: return

        if ((event.eventType and TARGET_EVENTS) == 0) return
        if (packageName == SYSTEM_UI_PACKAGE) return

        // Events from our own package (the host Flutter app and BlockedAppActivity)
        // must never trigger a block — the block screen IS our package.
        if (packageName == this.packageName) return

        if (packageName == lastPackage) return

        Log.d(TAG, "EVENT pkg=$packageName lastPkg=$lastPackage")
        lastPackage = packageName
        checkAndBlock(packageName)
    }

    // ------------------------------------------------------------------
    // Blocking logic
    // ------------------------------------------------------------------

    private fun checkAndBlock(packageName: String) {
        if (!preferences.isBlocking()) return

        val blockAll = preferences.isBlockAll()
        val blockedApps = preferences.getBlockedApps()
        val shouldBlock = when {
            blockAll -> isUserApp(packageName)
            else -> blockedApps.contains(packageName)
        }

        Log.d(TAG, "checkAndBlock: pkg=$packageName blockAll=$blockAll shouldBlock=$shouldBlock")

        if (!shouldBlock) return

        // Ignore duplicate accessibility events while a block-screen launch is
        // already pending. Events from Academia itself are filtered above.
        if (blockScreenLaunchPending) return

        // Press home immediately so the blocked app is no longer visible,
        // then show the block screen after a short settling delay.
        lastPackage = ""
        blockScreenLaunchPending = true
        performGlobalAction(GLOBAL_ACTION_HOME)
        handler.postDelayed({
            blockScreenLaunchPending = false
            openAcademiaBlockScreen(packageName)
        }, BLOCK_LAUNCH_DELAY_MS)

        Log.d(TAG, "checkAndBlock: BLOCK pkg=$packageName")
        BlockEventStreamHandler.sendEvent(
            mapOf(
                "type" to "attemptedAccess",
                "packageName" to packageName,
                "timestamp" to System.currentTimeMillis(),
            )
        )
    }

    private fun openAcademiaBlockScreen(blockedPackageName: String) {
        val uri = Uri.Builder()
            .scheme("https")
            .authority("academia.opencrafts.io")
            .appendPath("lock-in")
            .appendPath("blocked")
            .appendQueryParameter("packageName", blockedPackageName)
            .appendQueryParameter("timestamp", System.currentTimeMillis().toString())
            .build()

        startActivity(Intent(Intent.ACTION_VIEW, uri).apply {
            // This targets the host Flutter application directly, avoiding an
            // Android resolver while still letting Flutter receive the link.
            setPackage(this@AppBlockerAccessibilityService.packageName)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        })
    }

    /**
     * Returns true if [packageName] belongs to a user-installed app (not a
     * system app). Used when blocking all apps to avoid blocking system components.
     */
    private fun isUserApp(packageName: String): Boolean {
        return try {
            val appInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getApplicationInfo(
                    packageName,
                    android.content.pm.PackageManager.ApplicationInfoFlags.of(0),
                )
            } else {
                @Suppress("DEPRECATION")
                packageManager.getApplicationInfo(packageName, 0)
            }
            (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) == 0
        } catch (_: Exception) {
            false
        }
    }
}
