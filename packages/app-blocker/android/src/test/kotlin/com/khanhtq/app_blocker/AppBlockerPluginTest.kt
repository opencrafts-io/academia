package com.khanhtq.app_blocker

import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import kotlin.test.assertEquals

/**
 * Unit tests for [AppBlockerPlugin] constants and contract.
 *
 * Full integration (method-call routing, manager interaction) requires an
 * Android instrumented test with a real Flutter engine and is covered in
 * the example app's integration tests. These unit tests verify the stable
 * parts of the plugin that don't need a running engine.
 */
internal class AppBlockerPluginTest {

    @Test
    fun `error codes match dart constants`() {
        assertEquals("PERMISSION_DENIED", AppBlockerPlugin.ERROR_PERMISSION_DENIED)
        assertEquals("SERVICE_UNAVAILABLE", AppBlockerPlugin.ERROR_SERVICE_UNAVAILABLE)
        assertEquals("SCHEDULE_CONFLICT", AppBlockerPlugin.ERROR_SCHEDULE_CONFLICT)
        assertEquals("PROFILE_NOT_FOUND", AppBlockerPlugin.ERROR_PROFILE_NOT_FOUND)
        assertEquals("INVALID_CONFIG", AppBlockerPlugin.ERROR_INVALID_CONFIG)
    }
}
