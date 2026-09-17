import 'package:academia/features/sherehe/sherehe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_link_event.dart';
part 'ticket_link_state.dart';

class TicketLinkBloc extends Bloc<TicketLinkEvent, TicketLinkState> {
  final GetTicketInvitesUsecase getTicketInvites;
  final CreateTicketInviteUsecase createTicketInvite;
  final UpdateTicketInviteUsecase updateTicketInvite;
  final DeleteTicketInviteUsecase deleteTicketInvite;

  TicketLinkBloc({
    required this.getTicketInvites,
    required this.createTicketInvite,
    required this.updateTicketInvite,
    required this.deleteTicketInvite,
  }) : super(TicketLinkInitialState()) {
    on<GetTicketInvites>(_onGetTicketInvites);
    on<CreateTicketInvite>(_onCreateTicketInvite);
    on<UpdateTicketInvite>(_onUpdateTicketInvite);
    on<DeleteTicketInvite>(_onDeleteTicketInvite);
  }

  Future<void> _onGetTicketInvites(
    GetTicketInvites event,
    Emitter<TicketLinkState> emit,
  ) async {
    emit(GetAllTicketInvitesLoading());

    final result = await getTicketInvites(event.ticketId);

    result.fold(
      (failure) => emit(GetAllTicketInvitesErrorState(message: failure.message)),
      (invites) => emit(GetAllTicketInvitesSuccess(invites: invites)),
    );
  }

  Future<void> _onCreateTicketInvite(
    CreateTicketInvite event,
    Emitter<TicketLinkState> emit,
  ) async {
    emit(CreateTicketInviteLoading());

    final result = await createTicketInvite(
      ticketId: event.ticketId,
      maxUses: event.maxUses,
      expiresAt: event.expiresAt,
    );

    result.fold(
      (failure) => emit(CreateTicketInviteErrorState(message: failure.message)),
      (message) => emit(CreateTicketInviteSuccess(message: message)),
    );

    add(GetTicketInvites(ticketId: event.ticketId));
  }

  Future<void> _onUpdateTicketInvite(
    UpdateTicketInvite event,
    Emitter<TicketLinkState> emit,
  ) async {
    emit(UpdateTicketInviteLoading());

    final result = await updateTicketInvite(
      inviteId: event.inviteId,
      maxUses: event.maxUses,
      expiresAt: event.expiresAt,
    );

    result.fold(
      (failure) => emit(UpdateTicketInviteErrorState(message: failure.message)),
      (invite) => emit(UpdateTicketInviteSuccess(invite: invite)),
    );

    add(GetTicketInvites(ticketId: event.ticketId));
  }

  Future<void> _onDeleteTicketInvite(
    DeleteTicketInvite event,
    Emitter<TicketLinkState> emit,
  ) async {
    emit(DeleteTicketInviteLoading());

    final result = await deleteTicketInvite(inviteId: event.inviteId);

    result.fold(
      (failure) => emit(DeleteTicketInviteErrorState(message: failure.message)),
      (message) => emit(DeleteTicketInviteSuccess(message: message)),
    );

    add(GetTicketInvites(ticketId: event.ticketId));
  }
}
