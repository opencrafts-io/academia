// Extension to capitalize the frequency string
extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}