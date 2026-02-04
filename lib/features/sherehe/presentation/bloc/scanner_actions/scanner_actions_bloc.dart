import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scanner_actions_event.dart';
part 'scanner_actions_state.dart';

class ScannerActionsBloc extends Bloc<ScannerActionsEvent, ScannerActionsState> {
  final SearchUsersByUsernameUsecase searchUsersByUsername;
  final AddEventScannerUsecase addEventScanner;
  final DeleteEventScannerUsecase deleteEventScanner;

  ScannerActionsBloc({
    required this.searchUsersByUsername,
    required this.addEventScanner,
    required this.deleteEventScanner,
  }) : super(ScannerActionsStateInitial()) {
    on<SearchUser>(_onSearchUser);
    on<AddScanner>(_onAddScanner);
    on<DeleteScanner>(_onDeleteScanner);
  }

  Future<void> _onSearchUser(
    SearchUser event,
    Emitter<ScannerActionsState> emit,
  ) async {
    emit(SearchUserLoading());

    final result = await searchUsersByUsername(query: event.query);

    result.fold(
      (failure) {
        emit(SearchUserFailure(failure.message));
      },
      (users) {
        emit(SearchUserSuccess(users: users));
      },
    );
  }

  Future<void> _onAddScanner(
    AddScanner event,
    Emitter<ScannerActionsState> emit,
  ) async {
    emit(AddScannerStateLoading());

    final result = await addEventScanner(
      eventId: event.eventId,
      userId: event.userId,
    );

    result.fold(
      (failure) {
        emit(AddScannerStateError(failure.message));
      },
      (scanner) {
        emit(AddScannerSuccess(scanner: scanner));
      },
    );
  }

  Future<void> _onDeleteScanner(
    DeleteScanner event,
    Emitter<ScannerActionsState> emit,
  ) async {
    emit(DeleteScannerLoading());
    final result = await deleteEventScanner(scannerId: event.scannerId);

    result.fold(
      (failure) {
        emit(DeleteScannerError(failure.message));
      },
      (message) {
        emit(DeleteScannerSuccess(message: message));
      },
    );
  }
}
