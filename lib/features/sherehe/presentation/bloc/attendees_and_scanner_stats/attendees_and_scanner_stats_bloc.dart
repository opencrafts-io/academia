import 'package:academia/features/sherehe/sherehe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendees_and_scanner_stats_event.dart';
part 'attendees_and_scanner_stats_state.dart';

class AttendeesAndScannerStatsBloc
    extends Bloc<AttendeesAndScannerStatsEvent, AttendeesAndScannerStatsState> {
  final GetAttendeesAndScannersUsecase getAttendeesAndScanners;

  AttendeesAndScannerStatsBloc({required this.getAttendeesAndScanners})
    : super(InitialState()) {
    on<GetAttendeesAndScanners>(_onFetchAttendeesAndScanners);
  }

  Future<void> _onFetchAttendeesAndScanners(
    GetAttendeesAndScanners event,
    Emitter<AttendeesAndScannerStatsState> emit,
  ) async {
    emit(LoadingState());

    final result = await getAttendeesAndScanners(eventId: event.eventId);

    result.fold(
      (failure) => emit(ErrorState(message: failure.message)),
      (stats) => emit(LoadedState(stats: stats)),
    );
  }
}
