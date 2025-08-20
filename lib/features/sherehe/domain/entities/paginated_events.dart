import 'package:academia/features/sherehe/domain/entities/event.dart';

class PaginatedEvents {
  final List<Event> events;
  final int? nextPage;

  PaginatedEvents({
    required this.events,
    required this.nextPage,
  });
}
