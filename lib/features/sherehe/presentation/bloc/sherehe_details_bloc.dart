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
    profileResult.fold(
          (profileFailure) {
             print("Warning: Failed to load user profile in details BLoC: $profileFailure");
      },
          (profile) {
        currentUserProfile = profile;
      },
    );

    final eventResult = await getSpecificEventUseCase.execute(eventId: event.eventId);
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
              (fetchedAttendees) {
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
    emit(currentState.copyWith(isUserAttending: false));
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
          firstName: profile.name,
          middleName: profile.name,
          lastName: profile.username ?? '',
          eventId: event.eventId,
          email: profile.email,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        if (newAttendee.email.isEmpty) {
          emit(MarkedAsGoingFailure(message: "Your email is missing. Cannot mark as going."));
          return;
        }

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
            final attendeesResult = await getAttendeesUseCase.execute(
              eventId: event.eventId,
              page: 1,
              limit: 300,
            );
            List<Attendee> updatedAttendees = currentState.attendees;
            bool isUserNowAttending = currentState.isUserAttending;
            await attendeesResult.fold(
                  (attendeeFailure) async {
                    print("Error re-fetching attendees after marking as going: $attendeeFailure");
              },
                  (fetchedAttendees) async {
                updatedAttendees = fetchedAttendees;
                isUserNowAttending = fetchedAttendees.any((att) => att.email == profile.email);
                  },
            );
            print("[DEBUG] ShereheDetailsBloc/_onMarkAsGoing: For Event ID '${currentState.event.id}', UserProfile Email: ${profile.email}");
            print("[DEBUG] ShereheDetailsBloc/_onMarkAsGoing: Re-fetched ${updatedAttendees.length} attendees after marking as going.");
            if (updatedAttendees.isNotEmpty) {
              print("[DEBUG] ShereheDetailsBloc/_onMarkAsGoing: First re-fetched attendee: ${updatedAttendees.first.firstName} ${updatedAttendees.first.lastName} (${updatedAttendees.first.email})");
            }
            print("[DEBUG] ShereheDetailsBloc/_onMarkAsGoing: isUserNowAttending determined as: $isUserNowAttending");

                emit(ShereheDetailsLoaded(
              event: currentState.event,
              attendees: updatedAttendees,
              isUserAttending: isUserNowAttending,
              currentUserProfile: currentState.currentUserProfile ?? profile,
              showConfettiEffect: true,
            ));
            await Future.delayed(const Duration(milliseconds: 100));
            final finalState = state;
            if (finalState is ShereheDetailsLoaded && finalState.showConfettiEffect) {
              emit(finalState.copyWith(showConfettiEffect: false));
            }
          },
        );
      },
    );
  }
}