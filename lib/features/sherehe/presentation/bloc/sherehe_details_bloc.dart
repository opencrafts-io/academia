import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/domain.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/profile/domain/domain.dart';

part 'sherehe_details_event.dart';
part 'sherehe_details_state.dart';

class ShereheDetailsBloc extends Bloc<ShereheDetailsEvent, ShereheDetailsState> {
  final GetSpecificEvent getSpecificEventUseCase;
  final GetAttendee getAttendeesUseCase;
  final CreateAttendeeUseCase createAttendeeUseCase;
  final GetCachedProfileUsecase getCachedUserProfileUseCase;

  ShereheDetailsBloc({
    required this.getSpecificEventUseCase,
    required this.getAttendeesUseCase,
    required this.createAttendeeUseCase,
    required this.getCachedUserProfileUseCase,
  }) : super(ShereheDetailsInitial()) {
    on<LoadShereheDetails>(_onLoadShereheDetails);
    on<MarkAsGoing>(_onMarkAsGoing);
  }

  Future<void> _onLoadShereheDetails(
      LoadShereheDetails event,
      Emitter<ShereheDetailsState> emit,
      ) async {
    emit(ShereheDetailsLoading());
    final profileResult = await getCachedUserProfileUseCase(NoParams());
    UserProfile? currentUserProfile;
    await profileResult.fold(
          (profileFailure) {
        // TODO: Handle profile fetch failure, log it
             print("Warning: Failed to load user profile in details BLoC: $profileFailure");
      },
          (profile) {
        currentUserProfile = profile;
      },
    );

    final eventResult = await getSpecificEventUseCase.execute(event.eventId);
    await eventResult.fold(
          (eventFailure) async {
        String errorMessage = 'An unexpected error occurred.';
        if (eventFailure is ServerFailure) {
          errorMessage = eventFailure.message;
        } else if (eventFailure is CacheFailure) {
          errorMessage = eventFailure.message;
        } else if (eventFailure is NoDataFoundFailure) {
          errorMessage = eventFailure.message;
        }
        emit(ShereheDetailsError(message: errorMessage));
      },
          (event) async {
        final attendeesResult = await getAttendeesUseCase.execute(
          eventId: event.id,
          page: 1,
          limit: 300,
        );
        List<Attendee> attendees = [];
        bool isUserAttending = false;
        await attendeesResult.fold(
              (attendeeFailure) async {
            // TODO: Handle attendee fetch failure, log it
          },
              (fetchedAttendees) async {
            attendees = fetchedAttendees;
            if (currentUserProfile != null) {
              isUserAttending = attendees.any((attendee) => attendee.email == currentUserProfile!.email);
            }
          },
        );
        emit(ShereheDetailsLoaded(
          event: event,
          attendees: attendees,
          isUserAttending: isUserAttending,
            currentUserProfile: currentUserProfile
        ));
      },
    );
  }

  Future<void> _onMarkAsGoing(
      MarkAsGoing event,
      Emitter<ShereheDetailsState> emit,
      ) async {
    final currentState = state;
    if (currentState is! ShereheDetailsLoaded) {
      emit(ShereheDetailsError(message: "Event details not loaded. Please try again."));
      return;
    }

    emit(MarkingAsGoing());

    final profileResult = await getCachedUserProfileUseCase(NoParams());
    await profileResult.fold(
          (profileFailure) async {
        String errorMessage = 'Could not retrieve your profile.';
        if (profileFailure is CacheFailure) {
          errorMessage = profileFailure.message;
        } else if (profileFailure is NoDataFoundFailure) {
          errorMessage = "Please complete your profile first.";
        } else if (profileFailure is ServerFailure) {
          errorMessage = profileFailure.message;
        }
        emit(MarkedAsGoingFailure(message: errorMessage));
      },
          (profile) async {
        final newAttendee = Attendee(
          id: '',
          firstName: profile.name ?? '',
          middleName: profile.name ?? '',
          lastName: profile.username ?? '',
          eventId: event.eventId,
          email: profile.email ?? '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final createResult = await createAttendeeUseCase(newAttendee);
        await createResult.fold(
              (createFailure) async {
            String errorMessage = 'Failed to mark you as going.';
            if (createFailure is ServerFailure) {
              errorMessage = createFailure.message;
            } else if (createFailure is CacheFailure) {
              errorMessage = createFailure.message;
            }
            emit(MarkedAsGoingFailure(message: errorMessage));
          },
              (createdAttendee) async {
            emit(MarkedAsGoingSuccess());
            final attendeesResult = await getAttendeesUseCase.execute(
              eventId: event.eventId,
              page: 1,
              limit: 200,
            );
            List<Attendee> updatedAttendees = currentState.attendees;
            await attendeesResult.fold(
                  (attendeeFailure) async {
                // TODO: Log error, keep existing list
              },
                  (fetchedAttendees) async {
                updatedAttendees = fetchedAttendees;
              },
            );
            emit(ShereheDetailsLoaded(
              event: currentState.event,
              attendees: updatedAttendees,
              isUserAttending: true, currentUserProfile: currentState.currentUserProfile ?? profile
            ));
          },
        );
      },
    );
  }
}