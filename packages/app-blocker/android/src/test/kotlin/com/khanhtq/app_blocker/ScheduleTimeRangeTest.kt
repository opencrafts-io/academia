package com.khanhtq.app_blocker

import com.khanhtq.app_blocker.scheduling.ScheduleManager
import kotlin.test.Test
import kotlin.test.assertFalse
import kotlin.test.assertTrue

/**
 * Unit tests for schedule time range checking, especially overnight schedules.
 */
internal class ScheduleTimeRangeTest {

    @Test
    fun `same-day schedule - active during range`() {
        // 9:00 → 17:00, current: 12:00
        assertTrue(ScheduleManager.isTimeInRange(720, 540, 1020))
    }

    @Test
    fun `same-day schedule - inactive before range`() {
        // 9:00 → 17:00, current: 8:00
        assertFalse(ScheduleManager.isTimeInRange(480, 540, 1020))
    }

    @Test
    fun `same-day schedule - inactive after range`() {
        // 9:00 → 17:00, current: 18:00
        assertFalse(ScheduleManager.isTimeInRange(1080, 540, 1020))
    }

    @Test
    fun `overnight schedule - active before midnight`() {
        // 22:00 → 6:00, current: 23:00
        assertTrue(ScheduleManager.isTimeInRange(1380, 1320, 360))
    }

    @Test
    fun `overnight schedule - active at midnight`() {
        // 22:00 → 6:00, current: 0:00
        assertTrue(ScheduleManager.isTimeInRange(0, 1320, 360))
    }

    @Test
    fun `overnight schedule - active after midnight`() {
        // 22:00 → 6:00, current: 3:00
        assertTrue(ScheduleManager.isTimeInRange(180, 1320, 360))
    }

    @Test
    fun `overnight schedule - inactive in middle of day`() {
        // 22:00 → 6:00, current: 12:00
        assertFalse(ScheduleManager.isTimeInRange(720, 1320, 360))
    }

    @Test
    fun `overnight schedule - inactive at end time`() {
        // 22:00 → 6:00, current: 6:00
        assertFalse(ScheduleManager.isTimeInRange(360, 1320, 360))
    }
}
