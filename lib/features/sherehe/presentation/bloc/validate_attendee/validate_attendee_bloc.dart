import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'validate_attendee_event.dart';
part 'validate_attendee_state.dart';

class ValidateAttendeeBloc
    extends Bloc<ValidateAttendeeEvent, ValidateAttendeeState> {
  final ValidateAttendeeUseCase validateAttendeeUseCase;

  ValidateAttendeeBloc({required this.validateAttendeeUseCase})
    : super(ValidateAttendeeInitial()) {
    on<ValidateAttendee>(_onValidateAttendee);
  }

  Future<void> _onValidateAttendee(
    ValidateAttendee event,
    Emitter<ValidateAttendeeState> emit,
  ) async {
    emit(ValidateAttendeeLoading());

    final result = await validateAttendeeUseCase(
      eventId: event.eventId,
      attendeeId: event.attendeeId,
    );

    result.fold(
      (failure) {
        emit(ValidateAttendeeError(message: failure.message));
      },
      (status) {
        emit(ValidateAttendeeLoaded(status: status));
      },
    );
  }
}
