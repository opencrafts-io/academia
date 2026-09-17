part of 'ticket_link_bloc.dart';

abstract class TicketLinkEvent extends Equatable {
  const TicketLinkEvent();

  @override
  List<Object?> get props => [];
}

class GetTicketInvites extends TicketLinkEvent {
  final String ticketId;

  const GetTicketInvites({required this.ticketId});

  @override
  List<Object?> get props => [ticketId];
}

class CreateTicketInvite extends TicketLinkEvent {
  final String ticketId;
  final int maxUses;
  final String expiresAt;

  const CreateTicketInvite({
    required this.ticketId,
    required this.maxUses,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [ticketId, maxUses, expiresAt];
}

class UpdateTicketInvite extends TicketLinkEvent {
  final String ticketId;
  final String inviteId;
  final int? maxUses;
  final String? expiresAt;

  const UpdateTicketInvite({
    required this.ticketId,
    required this.inviteId,
    this.maxUses,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [ticketId, inviteId, maxUses, expiresAt];
}

class DeleteTicketInvite extends TicketLinkEvent {
  final String ticketId;
  final String inviteId;

  const DeleteTicketInvite({required this.inviteId, required this.ticketId});

  @override
  List<Object?> get props => [inviteId, ticketId];
}
