part of 'event_link_bloc.dart';

abstract class EventLinkEvent extends Equatable {
  const EventLinkEvent();

  @override
  List<Object?> get props => [];
}

class GetEventInvites extends EventLinkEvent {
  final String eventId;

  const GetEventInvites({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}

class CreateEventInvite extends EventLinkEvent {
  final String eventId;
  final int maxUses;
  final String expiresAt;

  const CreateEventInvite({
    required this.eventId,
    required this.maxUses,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [eventId, maxUses, expiresAt];
}

class UpdateEventInvite extends EventLinkEvent {
  final String eventId;
  final String inviteId;
  final int? maxUses;
  final String? expiresAt;

  const UpdateEventInvite({
    required this.eventId,
    required this.inviteId,
    this.maxUses,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [eventId, inviteId, maxUses, expiresAt];
}

class DeleteEventInvite extends EventLinkEvent {
  final String eventId;
  final String inviteId;

  const DeleteEventInvite({required this.inviteId, required this.eventId});

  @override
  List<Object?> get props => [inviteId, eventId];
}
