package com.khanhtq.app_blocker

import com.khanhtq.app_blocker.scheduling.ProfileData
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue

/**
 * Unit tests for [ProfileData] serialisation and deserialisation.
 */
internal class ProfileDataTest {

    private fun scheduleMap(id: String = "s1"): Map<String, Any?> = mapOf(
        "id" to id,
        "name" to "Test schedule",
        "appIdentifiers" to listOf("com.example.app"),
        "weekdays" to listOf(1, 2),
        "startHour" to 9,
        "startMinute" to 0,
        "endHour" to 17,
        "endMinute" to 0,
        "enabled" to true,
    )

    private fun profileMap(
        id: String = "prof-1",
        name: String = "Work",
        appIdentifiers: List<String> = listOf("com.example.app"),
        schedules: List<Map<String, Any?>> = listOf(scheduleMap()),
        isActive: Boolean = false,
    ): Map<String, Any?> = mapOf(
        "id" to id,
        "name" to name,
        "appIdentifiers" to appIdentifiers,
        "schedules" to schedules,
        "isActive" to isActive,
    )

    @Test
    fun `fromMap round-trips through toMap`() {
        val profile = ProfileData.fromMap(profileMap())
        val restored = profile.toMap()

        assertEquals("prof-1", restored["id"])
        assertEquals("Work", restored["name"])
        assertEquals(listOf("com.example.app"), restored["appIdentifiers"])
        assertFalse(restored["isActive"] as Boolean)

        @Suppress("UNCHECKED_CAST")
        val schedules = restored["schedules"] as List<Map<String, Any?>>
        assertEquals(1, schedules.size)
        assertEquals("s1", schedules[0]["id"])
    }

    @Test
    fun `fromMap defaults name to empty string when absent`() {
        val map = profileMap().toMutableMap().apply { remove("name") }
        val profile = ProfileData.fromMap(map)
        assertEquals("", profile.name)
    }

    @Test
    fun `fromMap defaults isActive to false when absent`() {
        val map = profileMap().toMutableMap().apply { remove("isActive") }
        val profile = ProfileData.fromMap(map)
        assertFalse(profile.isActive)
    }

    @Test
    fun `fromMap treats missing appIdentifiers as empty list`() {
        val map = profileMap().toMutableMap().apply { remove("appIdentifiers") }
        val profile = ProfileData.fromMap(map)
        assertTrue(profile.appIdentifiers.isEmpty())
    }

    @Test
    fun `fromMap treats missing schedules as empty list`() {
        val map = profileMap().toMutableMap().apply { remove("schedules") }
        val profile = ProfileData.fromMap(map)
        assertTrue(profile.schedules.isEmpty())
    }

    @Test
    fun `fromMap ignores non-map entries in schedules list`() {
        val map = profileMap(schedules = emptyList())
        val profile = ProfileData.fromMap(map)
        assertTrue(profile.schedules.isEmpty())
    }

    @Test
    fun `copy preserves all fields`() {
        val original = ProfileData.fromMap(profileMap())
        val activated = original.copy(isActive = true)

        assertTrue(activated.isActive)
        assertEquals(original.id, activated.id)
        assertEquals(original.name, activated.name)
        assertEquals(original.appIdentifiers, activated.appIdentifiers)
        assertEquals(original.schedules, activated.schedules)
    }

    @Test
    fun `data class equality is structural`() {
        val a = ProfileData.fromMap(profileMap())
        val b = ProfileData.fromMap(profileMap())
        assertEquals(a, b)
        assertEquals(a.hashCode(), b.hashCode())
    }
}
