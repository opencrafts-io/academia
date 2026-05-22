import 'package:academia/features/sherehe/sherehe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_link_event.dart';
part 'event_link_state.dart';

class EventLinkBloc extends Bloc<EventLinkEvent, EventLinkState> {
  final GetEventInvitesUsecase getEventInvites;
  final CreateEventInviteUsecase createEventInvite;
  final UpdateEventInviteUsecase updateEventInvite;
  final DeleteEventInviteUsecase deleteEventInvite;

  EventLinkBloc({
    required this.getEventInvites,
    required this.createEventInvite,
    required this.updateEventInvite,
    required this.deleteEventInvite,
  }) : super(EventLinkInitialState()) {
    on<GetEventInvites>(_onGetEventInvites);
    on<CreateEventInvite>(_onCreateEventInvite);
    on<UpdateEventInvite>(_onUpdateEventInvite);
    on<DeleteEventInvite>(_onDeleteEventInvite);
  }

  Future<void> _onGetEventInvites(
    GetEventInvites event,
    Emitter<EventLinkState> emit,
  ) async {
    emit(GetAllEventInvitesLoading());

    final result = await getEventInvites(event.eventId);

    result.fold(
      (failure) => emit(GetAllEventInvitesErrorState(message: failure.message)),
      (invites) => emit(GetAllEventInvitesSuccess(invites: invites)),
    );
  }

  Future<void> _onCreateEventInvite(
    CreateEventInvite event,
    Emitter<EventLinkState> emit,
  ) async {
    emit(CreateEventInviteLoading());

    final result = await createEventInvite(
      eventId: event.eventId,
      maxUses: event.maxUses,
      expiresAt: event.expiresAt,
    );

    result.fold(
      (failure) => emit(CreateEventInviteErrorState(message: failure.message)),
      (message) => emit(CreateEventInviteSuccess(message: message)),
    );

    add(GetEventInvites(eventId: event.eventId));
  }

  Future<void> _onUpdateEventInvite(
    UpdateEventInvite event,
    Emitter<EventLinkState> emit,
  ) async {
    emit(UpdateEventInviteLoading());

    final result = await updateEventInvite(
      inviteId: event.inviteId,
      maxUses: event.maxUses,
      expiresAt: event.expiresAt,
    );

    result.fold(
      (failure) => emit(UpdateEventInviteErrorState(message: failure.message)),
      (invite) => emit(UpdateEventInviteSuccess(invite: invite)),
    );
  }

  Future<void> _onDeleteEventInvite(
    DeleteEventInvite event,
    Emitter<EventLinkState> emit,
  ) async {
    emit(DeleteEventInviteLoading());

    final result = await deleteEventInvite(inviteId: event.inviteId);

    result.fold(
      (failure) => emit(DeleteEventInviteErrorState(message: failure.message)),
      (message) => emit(DeleteEventInviteSuccess(message: message)),
    );
  }
}
