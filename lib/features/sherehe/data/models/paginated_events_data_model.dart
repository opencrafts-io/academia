import 'package:academia/database/database.dart';

class PaginatedEventsData {
  final List<EventData> events;
  final int? nextPage;

  PaginatedEventsData({
    required this.events,
    required this.nextPage,
  });
}
