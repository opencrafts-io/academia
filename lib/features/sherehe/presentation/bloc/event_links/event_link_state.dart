part of 'event_link_bloc.dart';

abstract class EventLinkState extends Equatable {
  const EventLinkState();

  @override
  List<Object?> get props => [];
}

class EventLinkInitialState extends EventLinkState {}

class GetAllEventInvitesLoading extends EventLinkState {}

class GetAllEventInvitesSuccess extends EventLinkState {
  final List<Invite> invites;

  const GetAllEventInvitesSuccess({required this.invites});

  @override
  List<Object?> get props => [invites];
}

class GetAllEventInvitesErrorState extends EventLinkState {
  final String message;

  const GetAllEventInvitesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateEventInviteLoading extends EventLinkState {}

class CreateEventInviteSuccess extends EventLinkState {
  final String message;

  const CreateEventInviteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateEventInviteErrorState extends EventLinkState {
  final String message;

  const CreateEventInviteErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UpdateEventInviteLoading extends EventLinkState {}

class UpdateEventInviteSuccess extends EventLinkState {
  final Invite invite;

  const UpdateEventInviteSuccess({required this.invite});

  @override
  List<Object?> get props => [invite];
}

class UpdateEventInviteErrorState extends EventLinkState {
  final String message;

  const UpdateEventInviteErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteEventInviteLoading extends EventLinkState {}

class DeleteEventInviteSuccess extends EventLinkState {
  final String message;

  const DeleteEventInviteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteEventInviteErrorState extends EventLinkState {
  final String message;

  const DeleteEventInviteErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
