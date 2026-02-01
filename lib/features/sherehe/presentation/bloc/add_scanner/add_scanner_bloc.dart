import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_scanner_event.dart';
part 'add_scanner_state.dart';

class AddScannerBloc extends Bloc<AddScannerEvent, AddScannerState> {
  final SearchUsersByUsernameUsecase searchUsersByUsername;
  final AddEventScannerUsecase addEventScanner;

  AddScannerBloc({
    required this.searchUsersByUsername,
    required this.addEventScanner,
  }) : super(AddScannerStateInitial()) {
    on<SearchUser>(_onSearchUser);
    on<AddScanner>(_onAddScanner);
  }

  Future<void> _onSearchUser(
    SearchUser event,
    Emitter<AddScannerState> emit,
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
    Emitter<AddScannerState> emit,
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
}
