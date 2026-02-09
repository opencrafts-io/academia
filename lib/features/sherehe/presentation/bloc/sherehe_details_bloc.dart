import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sherehe_details_event.dart';
part 'sherehe_details_state.dart';

class ShereheDetailsBloc
    extends Bloc<ShereheDetailsEvent, ShereheDetailsState> {
  final GetSpecificEvent getSpecificEventUseCase;

  ShereheDetailsBloc({required this.getSpecificEventUseCase})
    : super(ShereheDetailsInitial()) {
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

    emit(ShereheDetailsLoading());

    final result = await getSpecificEventUseCase.execute(
      eventId: event.eventId,
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
