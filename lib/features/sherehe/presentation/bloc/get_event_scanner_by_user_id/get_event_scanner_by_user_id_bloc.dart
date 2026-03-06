import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_event_scanner_by_user_id_event.dart';
part 'get_event_scanner_by_user_id_state.dart';

class GetEventScannerByUserIdBloc
    extends Bloc<GetEventScannerByUserIdEvent, GetEventScannerByUserIdState> {
  final GetEventScannerByUserIdUsecase getEventScannerByUserId;

  GetEventScannerByUserIdBloc({required this.getEventScannerByUserId})
    : super(GetEventScannerByUserIdStateInitial()) {
    on<GetEventScannerByUserId>(_onGetEventScannerByUserId);
  }

  Future<void> _onGetEventScannerByUserId(
    GetEventScannerByUserId event,
    Emitter<GetEventScannerByUserIdState> emit,
  ) async {
    emit(GetEventScannerByUserIdStateLoading());
    final result = await getEventScannerByUserId(eventId: event.eventId);

    result.fold(
      (failure) {
        emit(GetEventScannerByUserIdStateError(failure.message));
      },
      (message) {
        emit(GetEventScannerByUserIdSuccess(message: message));
      },
    );
  }
}
