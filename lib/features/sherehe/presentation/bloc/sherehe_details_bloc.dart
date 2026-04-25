import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sherehe_details_event.dart';
part 'sherehe_details_state.dart';

class ShereheDetailsBloc
    extends Bloc<ShereheDetailsEvent, ShereheDetailsState> {
  final GetSpecificEvent getSpecificEventUseCase;
  final GetEventByInviteUsecase getEventByInviteUsecase;

  ShereheDetailsBloc({
    required this.getSpecificEventUseCase,
    required this.getEventByInviteUsecase,
  }) : super(ShereheDetailsInitial()) {
    on<LoadShereheDetails>(_onLoadShereheDetails);
  }

  Future<void> _onLoadShereheDetails(
    LoadShereheDetails event,
    Emitter<ShereheDetailsState> emit,
  ) async {
    if (event.initialEvent != null) {
      emit(ShereheDetailsLoaded(event: event.initialEvent!));
      return;
    }

    if (event.invite != null) {
      final result = await getEventByInviteUsecase(invite: event.invite!);

      result.fold(
        (failure) {
          emit(ShereheDetailsError(message: failure.message));
        },
        (event) {
          emit(ShereheDetailsLoaded(event: event));
        },
      );
    }

    // if initialEvent and invite are both null, then we try to fetch the event by id

    emit(ShereheDetailsLoading());

    final result = await getSpecificEventUseCase.execute(
      eventId: event.eventId ?? '',
    );

    result.fold(
      (failure) {
        emit(ShereheDetailsError(message: failure.message));
      },
      (event) {
        emit(ShereheDetailsLoaded(event: event));
      },
    );
  }
}
