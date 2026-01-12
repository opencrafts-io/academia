import 'package:academia/database/database.dart';

class PaginatedEventsData {
  final List<EventData> events;
  final int? nextPage;
  final int? previousPage;
  final int totalEvents;

  PaginatedEventsData({
    required this.events,
    this.nextPage,
    this.previousPage,
    required this.totalEvents,
  });
}
