abstract interface class CourseReminderRefresher {
  Future<void> refresh();

  void updatePreferences({
    required bool enabled,
    required List<int?> reminderMinutes,
  });
}
