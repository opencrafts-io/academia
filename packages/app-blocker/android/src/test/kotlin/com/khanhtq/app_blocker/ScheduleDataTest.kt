package com.khanhtq.app_blocker

import com.khanhtq.app_blocker.scheduling.ScheduleData
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertFalse
import kotlin.test.assertTrue

/**
 * Unit tests for [ScheduleData] serialisation and deserialisation.
 */
internal class ScheduleDataTest {

    private fun sampleMap(
        id: String = "sched-1",
        name: String = "Morning block",
        appIdentifiers: List<String> = listOf("com.example.app"),
        weekdays: List<Int> = listOf(1, 2, 3, 4, 5),
        startHour: Int = 9,
        startMinute: Int = 0,
        endHour: Int = 17,
        endMinute: Int = 30,
        enabled: Boolean = true,
    ): Map<String, Any?> = mapOf(
        "id" to id,
        "name" to name,
        "appIdentifiers" to appIdentifiers,
        "weekdays" to weekdays,
        "startHour" to startHour,
        "startMinute" to startMinute,
        "endHour" to endHour,
        "endMinute" to endMinute,
        "enabled" to enabled,
    )

    @Test
    fun `fromMap round-trips through toMap`() {
        val original = sampleMap()
        val schedule = ScheduleData.fromMap(original)
        val restored = schedule.toMap()

        assertEquals("sched-1", restored["id"])
        assertEquals("Morning block", restored["name"])
        assertEquals(listOf("com.example.app"), restored["appIdentifiers"])
        assertEquals(listOf(1, 2, 3, 4, 5), restored["weekdays"])
        assertEquals(9, restored["startHour"])
        assertEquals(0, restored["startMinute"])
        assertEquals(17, restored["endHour"])
        assertEquals(30, restored["endMinute"])
        assertEquals(true, restored["enabled"])
    }

    @Test
    fun `fromMap accepts numeric weekdays from different Number types`() {
        val map = sampleMap(weekdays = listOf(1, 7))
        val schedule = ScheduleData.fromMap(map)
        assertEquals(listOf(1, 7), schedule.weekdays)
    }

    @Test
    fun `fromMap defaults enabled to true when absent`() {
        val map = sampleMap().toMutableMap().apply { remove("enabled") }
        val schedule = ScheduleData.fromMap(map)
        assertTrue(schedule.enabled)
    }

    @Test
    fun `fromMap defaults name to empty string when absent`() {
        val map = sampleMap().toMutableMap().apply { remove("name") }
        val schedule = ScheduleData.fromMap(map)
        assertEquals("", schedule.name)
    }

    @Test
    fun `fromMap treats missing appIdentifiers as empty list`() {
        val map = sampleMap().toMutableMap().apply { remove("appIdentifiers") }
        val schedule = ScheduleData.fromMap(map)
        assertTrue(schedule.appIdentifiers.isEmpty())
    }

    @Test
    fun `fromMap treats missing weekdays as empty list`() {
        val map = sampleMap().toMutableMap().apply { remove("weekdays") }
        val schedule = ScheduleData.fromMap(map)
        assertTrue(schedule.weekdays.isEmpty())
    }

    @Test
    fun `copy preserves all fields`() {
        val original = ScheduleData.fromMap(sampleMap())
        val copy = original.copy(enabled = false)

        assertFalse(copy.enabled)
        assertEquals(original.id, copy.id)
        assertEquals(original.name, copy.name)
        assertEquals(original.appIdentifiers, copy.appIdentifiers)
        assertEquals(original.weekdays, copy.weekdays)
    }

    @Test
    fun `data class equality is structural`() {
        val a = ScheduleData.fromMap(sampleMap())
        val b = ScheduleData.fromMap(sampleMap())
        assertEquals(a, b)
        assertEquals(a.hashCode(), b.hashCode())
    }

    @Test
    fun `fromMap rejects weekday less than 1`() {
        val map = sampleMap(weekdays = listOf(0, 1, 2))
        val exception = assertFailsWith<IllegalArgumentException> {
            ScheduleData.fromMap(map)
        }
        assertTrue(exception.message!!.contains("ISO 8601"))
    }

    @Test
    fun `fromMap rejects weekday greater than 7`() {
        val map = sampleMap(weekdays = listOf(1, 8))
        val exception = assertFailsWith<IllegalArgumentException> {
            ScheduleData.fromMap(map)
        }
        assertTrue(exception.message!!.contains("ISO 8601"))
    }

    @Test
    fun `fromMap accepts valid weekday range 1 to 7`() {
        val map = sampleMap(weekdays = listOf(1, 2, 3, 4, 5, 6, 7))
        val schedule = ScheduleData.fromMap(map)
        assertEquals(listOf(1, 2, 3, 4, 5, 6, 7), schedule.weekdays)
    }
}
