/// Formats a timer duration as `mm:ss`, keeping long focus sessions intact.
String formatPomodoroCountdown(Duration duration) {
  final minutes = duration.inMinutes.toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

/// Formats accumulated focus time for display, e.g. "1h 5m" or "45m".
/// Durations under a minute show as "< 1m" rather than "0m".
String formatFocusedDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);

  if (hours > 0) {
    return minutes > 0 ? "${hours}h ${minutes}m" : "${hours}h";
  }
  if (minutes > 0) return "${minutes}m";
  return "< 1m";
}
