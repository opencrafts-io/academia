import 'package:academia/features/sherehe/domain/entities/event.dart';

class PaginatedEvents {
  final List<Event> events;
  final int? nextPage;
  final int? previousPage;
  final int totalEvents;

  PaginatedEvents({
    required this.events,
    this.nextPage,
    this.previousPage,
    required this.totalEvents,
  });

  bool get hasMore => nextPage != null;
}
