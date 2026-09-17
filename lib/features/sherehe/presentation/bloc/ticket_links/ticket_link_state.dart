part of 'ticket_link_bloc.dart';

abstract class TicketLinkState extends Equatable {
  const TicketLinkState();

  @override
  List<Object?> get props => [];
}

class TicketLinkInitialState extends TicketLinkState {}

class GetAllTicketInvitesLoading extends TicketLinkState {}

class GetAllTicketInvitesSuccess extends TicketLinkState {
  final List<Invite> invites;

  const GetAllTicketInvitesSuccess({required this.invites});

  @override
  List<Object?> get props => [invites];
}

class GetAllTicketInvitesErrorState extends TicketLinkState {
  final String message;

  const GetAllTicketInvitesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateTicketInviteLoading extends TicketLinkState {}

class CreateTicketInviteSuccess extends TicketLinkState {
  final String message;

  const CreateTicketInviteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateTicketInviteErrorState extends TicketLinkState {
  final String message;

  const CreateTicketInviteErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class UpdateTicketInviteLoading extends TicketLinkState {}

class UpdateTicketInviteSuccess extends TicketLinkState {
  final Invite invite;

  const UpdateTicketInviteSuccess({required this.invite});

  @override
  List<Object?> get props => [invite];
}

class UpdateTicketInviteErrorState extends TicketLinkState {
  final String message;

  const UpdateTicketInviteErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteTicketInviteLoading extends TicketLinkState {}

class DeleteTicketInviteSuccess extends TicketLinkState {
  final String message;

  const DeleteTicketInviteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteTicketInviteErrorState extends TicketLinkState {
  final String message;

  const DeleteTicketInviteErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
