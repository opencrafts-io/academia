package com.khanhtq.app_blocker

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.Drawable
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.ByteArrayOutputStream

/**
 * Resolves installed user-facing applications and converts their metadata
 * into maps suitable for the Flutter platform channel.
 */
class AppResolver(private val context: Context) {

    /**
     * Returns a list of installed user (non-system) apps, each represented
     * as a map with keys:
     *
     * - `packageName` (String)
     * - `appName`     (String)
     * - `icon`        (ByteArray — PNG encoded)
     * - `isSystemApp` (Boolean)
     *
     * The list is sorted alphabetically by app name.
     * This is a suspend function and should be called from a coroutine.
     */
    suspend fun getInstalledApps(): List<Map<String, Any?>> = withContext(Dispatchers.IO) {
        val pm = context.packageManager

        // Discover launchable apps via the LAUNCHER category.
        val launcherIntent = Intent(Intent.ACTION_MAIN, null).apply {
            addCategory(Intent.CATEGORY_LAUNCHER)
        }
        val resolveInfoList = pm.queryIntentActivities(launcherIntent, 0)

        // Determine the default launcher package so we can exclude it.
        val launcherPackage = pm.resolveActivity(
            Intent(Intent.ACTION_MAIN).apply { addCategory(Intent.CATEGORY_HOME) },
            PackageManager.MATCH_DEFAULT_ONLY
        )?.activityInfo?.packageName

        resolveInfoList
            .filter { info ->
                val pkg = info.activityInfo.packageName
                // Exclude our own app and the default launcher.
                // All apps with CATEGORY_LAUNCHER are user-facing,
                // regardless of system flag.
                pkg != context.packageName &&
                    pkg != launcherPackage &&
                    pkg != "com.android.launcher"
            }
            .mapNotNull { info ->
                try {
                    val pkg = info.activityInfo.packageName
                    val label = info.loadLabel(pm).toString()
                    val icon = info.loadIcon(pm)
                    val isSystem = (info.activityInfo.applicationInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0

                    mapOf<String, Any?>(
                        "packageName" to pkg,
                        "appName" to label,
                        "icon" to drawableToByteArray(icon),
                        "isSystemApp" to isSystem,
                    )
                } catch (_: Exception) {
                    null
                }
            }
            .sortedBy { (it["appName"] as? String)?.lowercase() }
    }

    /**
     * Renders a [Drawable] into a PNG-encoded [ByteArray].
     */
    fun drawableToByteArray(drawable: Drawable): ByteArray {
        val width = drawable.intrinsicWidth.coerceAtLeast(1)
        val height = drawable.intrinsicHeight.coerceAtLeast(1)

        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)

        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 80, stream)
        bitmap.recycle()

        return stream.toByteArray()
    }
}
