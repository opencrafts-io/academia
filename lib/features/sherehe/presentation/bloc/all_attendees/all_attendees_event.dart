part of 'all_attendees_bloc.dart';

abstract class AllAttendeesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllAttendees extends AllAttendeesEvent {
  final String eventId;
  final int page;
  final int limit;

  FetchAllAttendees({
    required this.eventId,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [eventId, page, limit];
}
