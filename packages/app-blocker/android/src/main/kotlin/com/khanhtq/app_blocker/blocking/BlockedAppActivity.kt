package com.khanhtq.app_blocker.blocking

import android.annotation.SuppressLint
import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.ColorDrawable
import android.os.Build
import android.os.Bundle
import android.util.TypedValue
import android.view.Gravity
import android.view.Window
import android.view.WindowManager
import android.widget.FrameLayout
import android.widget.ImageButton
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.ContextCompat
import com.khanhtq.app_blocker.persistence.BlockerPreferences
import org.json.JSONObject

/**
 * Full-screen activity shown when a blocked app is detected in the foreground.
 *
 * Launched by [AppBlockerAccessibilityService] after pressing home, with a short
 * delay to let the system settle before the screen appears. Unlike the previous
 * overlay approach, this is a proper Android Activity which avoids:
 * - Spurious re-shows caused by ghost accessibility events after overlay dismissal
 * - The overlay remaining visible when the host app is brought to the foreground
 *
 * The close button and hardware back button both navigate explicitly to the
 * home screen before finishing, so the user is never returned to the blocked app.
 *
 * Send [ACTION_DISMISS] broadcast to close this activity programmatically
 * (e.g., when blocking is stopped from the Flutter side).
 */
class BlockedAppActivity : Activity() {

    companion object {
        const val ACTION_DISMISS = "com.khanhtq.app_blocker.DISMISS_BLOCK_SCREEN"

        /** `true` while this activity is in the resumed state. */
        @Volatile
        var isVisible: Boolean = false
    }

    private val dismissReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == ACTION_DISMISS) finish()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        window.setBackgroundDrawable(ColorDrawable(Color.BLACK))

        val prefs = BlockerPreferences(this)
        val config = parseConfig(prefs.overlayConfig)
        setContentView(buildLayout(config))
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    override fun onResume() {
        super.onResume()
        isVisible = true

        // Close immediately if blocking was deactivated while we were in the background.
        if (!BlockerPreferences(this).isBlocking()) {
            finish()
            return
        }

        val filter = IntentFilter(ACTION_DISMISS)
        ContextCompat.registerReceiver(
            this,
            dismissReceiver,
            filter,
            ContextCompat.RECEIVER_NOT_EXPORTED
        )
    }

    override fun onPause() {
        super.onPause()
        isVisible = false
        runCatching { unregisterReceiver(dismissReceiver) }
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        goHome()
    }

    // ------------------------------------------------------------------
    // Private helpers
    // ------------------------------------------------------------------

    private fun goHome() {
        startActivity(Intent(Intent.ACTION_MAIN).apply {
            addCategory(Intent.CATEGORY_HOME)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        })
        finish()
    }

    private fun parseConfig(json: String): BlockScreenConfig {
        return try {
            val obj = JSONObject(json)
            BlockScreenConfig(
                title = if (obj.has("title") && !obj.isNull("title")) obj.getString("title") else "App Blocked",
                subtitle = if (obj.has("subtitle") && !obj.isNull("subtitle")) obj.getString("subtitle") else "This app is currently blocked.",
                message = if (obj.has("message") && !obj.isNull("message")) obj.getString("message") else "",
                backgroundColor = if (obj.has("backgroundColor") && !obj.isNull("backgroundColor")) obj.getLong("backgroundColor").toInt() else Color.BLACK,
            )
        } catch (_: Exception) {
            BlockScreenConfig()
        }
    }

    private data class BlockScreenConfig(
        val title: String = "App Blocked",
        val subtitle: String = "This app is currently blocked.",
        val message: String = "",
        val backgroundColor: Int = Color.BLACK,
    )

    private fun buildLayout(config: BlockScreenConfig): FrameLayout {
        val root = FrameLayout(this).apply {
            setBackgroundColor(config.backgroundColor)
        }

        val content = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
        }

        val horizontalMargin = dpToPx(32f).toInt()
        root.addView(content, FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.WRAP_CONTENT,
        ).apply {
            gravity = Gravity.CENTER
            setMargins(horizontalMargin, 0, horizontalMargin, 0)
        })

        content.addView(
            buildTextView(config.title, 28f, Typeface.BOLD),
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT,
            ).apply { bottomMargin = dpToPx(12f).toInt() }
        )

        content.addView(
            buildTextView(config.subtitle, 18f, Typeface.NORMAL),
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT,
            ).apply { bottomMargin = dpToPx(8f).toInt() }
        )

        if (config.message.isNotEmpty()) {
            content.addView(
                buildTextView(config.message, 14f, Typeface.NORMAL),
                LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                )
            )
        }

        root.addView(buildCloseButton(), FrameLayout.LayoutParams(
            dpToPx(48f).toInt(),
            dpToPx(48f).toInt(),
        ).apply {
            gravity = Gravity.TOP or Gravity.END
            topMargin = dpToPx(16f).toInt()
            rightMargin = dpToPx(16f).toInt()
        })

        return root
    }

    private fun buildTextView(text: String, spSize: Float, style: Int): TextView {
        return TextView(this).apply {
            this.text = text
            setTextColor(Color.WHITE)
            setTextSize(TypedValue.COMPLEX_UNIT_SP, spSize)
            setTypeface(null, style)
            gravity = Gravity.CENTER
        }
    }

    private fun buildCloseButton(): ImageButton {
        return ImageButton(this).apply {
            setImageResource(android.R.drawable.ic_menu_close_clear_cancel)
            setBackgroundColor(Color.TRANSPARENT)
            scaleType = android.widget.ImageView.ScaleType.CENTER_INSIDE
            contentDescription = "Go to home screen"
            setOnClickListener { goHome() }
        }
    }

    private fun dpToPx(dp: Float): Float = dp * resources.displayMetrics.density
}
