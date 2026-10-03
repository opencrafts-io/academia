/// Returns whether a course's inclusive end date is before the local day.
bool hasCourseTermEnded(DateTime? termEndDate, {DateTime? now}) {
  return courseTermHasEndedOn(termEndDate, now ?? DateTime.now());
}

/// Returns whether the course's inclusive end date is before [day].
bool courseTermHasEndedOn(DateTime? termEndDate, DateTime day) {
  if (termEndDate == null) return false;

  final endDate = DateTime(
    termEndDate.year,
    termEndDate.month,
    termEndDate.day,
  );
  final targetDate = DateTime(day.year, day.month, day.day);
  return endDate.isBefore(targetDate);
}
