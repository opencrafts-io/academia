import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'attendee_event.dart';
part 'attendee_state.dart';

class AttendeeBloc extends Bloc<AttendeeEvent, AttendeeState> {
  final GetAttendee getAttendee;

  AttendeeBloc({required this.getAttendee}) : super(AttendeeInitial()) {
    on<FetchAttendees>(_onFetchAttendees);
  }

  Future<void> _onFetchAttendees(
    FetchAttendees event,
    Emitter<AttendeeState> emit,
  ) async {
    emit(AttendeeLoading());

    final result =
        await getAttendee.execute(eventId: event.eventId, page: 1, limit: 4);

    result.fold(
      (failure) => emit(AttendeeError(failure.message)),
      (paginated) => emit(AttendeeLoaded(attendees: paginated.results)),
    );
  }
}
