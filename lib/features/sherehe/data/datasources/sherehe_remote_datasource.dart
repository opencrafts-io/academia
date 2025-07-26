import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../../../core/core.dart';
import '../data.dart';

class ShereheRemoteDataSource {
  final Logger _logger = Logger();

  Future<Either<Failure, List<EventModel>>> getAllEvents() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      return right([
        EventModel(
          id: '1',
          name: 'Gender Reveal Party',
          description: 'Come celebrate the surprise!',
          url: '',
          location: 'Kryptons Apartments, Athi River',
          time: '14:00:00',
          date: '2025-07-20',
          organizer: 'Jane Doe',
          imageUrl: 'assets/images/gaelle-marcel-vrkSVpOwchk-unsplash.jpg',
          numberOfAttendees: 23,
          organizerId: 101,
          createdAt: '2025-07-01T10:00:00Z',
          genre: ['Family', 'Celebration', 'Casual'],
        ),
        EventModel(
          id: '2',
          name: 'Cocktail Thursday',
          description: 'Chill vibes and good drinks.',
          url: '',
          location: 'Pine Breeze Gateway, Athi River',
          time: '19:30:00',
          date: '2025-07-25',
          organizer: 'John Smith',
          imageUrl: 'assets/images/scott-warman-rrYF1RfotSM-unsplash.jpg',
          numberOfAttendees: 58,
          organizerId: 102,
          createdAt: '2025-07-05T11:00:00Z',
          genre: ['Social', 'Networking', 'Drinks'],
        ),
        EventModel(
          id: '3',
          name: 'Freshas Night',
          description: 'Welcome party for new students.',
          url: '',
          location: 'Sabina Joy, Nairobi CBD',
          time: '21:00:00',
          date: '2025-07-26',
          organizer: 'Campus Life',
          imageUrl: 'assets/images/lee-blanchflower-1dW1vEJLlCQ-unsplash.jpg',
          numberOfAttendees: 120,
          organizerId: 103,
          createdAt: '2025-07-06T13:00:00Z',
          genre: ['Party', 'Dance', 'University'],
        ),
        EventModel(
          id: '4',
          name: 'Beach Festival',
          description: 'Feel the sun, music, and sand!',
          url: '',
          location: 'Heri Homes, Athi River',
          time: '12:00:00',
          date: '2025-08-04',
          organizer: 'Beach Events KE',
          imageUrl: 'assets/images/al-elmes-ULHxWq8reao-unsplash.jpg',
          numberOfAttendees: 87,
          organizerId: 104,
          createdAt: '2025-07-10T09:00:00Z',
          genre: ['Outdoor', 'Festival', 'Music'],
        ),
        EventModel(
          id: '5',
          name: 'Singles Night',
          description: 'Meet, mingle, and dance the night away.',
          url: '',
          location: 'Nairobi Street Kitchen, Westlands',
          time: '20:00:00',
          date: '2025-08-09',
          organizer: 'Social Circles',
          imageUrl: 'assets/images/lavi-perchik-FCPV_n0lOxc-unsplash.jpg',
          numberOfAttendees: 43,
          organizerId: 105,
          createdAt: '2025-07-12T14:00:00Z',
          genre: ['Dating', 'Party', 'Social'],
        ),
        EventModel(
          id: '6',
          name: 'AfroBeats Night',
          description: 'Dance to the hottest Afrobeats tracks.',
          url: '',
          location: 'Captains Lounge, Mombasa Rd',
          time: '22:00:00',
          date: '2025-08-10',
          organizer: 'AfroVibes KE',
          imageUrl: 'assets/images/med-mhamdi-mH_E0K581Yk-unsplash.jpg',
          numberOfAttendees: 76,
          organizerId: 106,
          createdAt: '2025-07-15T18:00:00Z',
          genre: ['Music', 'Dance', 'Nightlife'],
        ),
      ]);
    } catch (e) {
      _logger.e("Failed to get events", error: e);
      return left(
        //Placeholder Failure for now
        ServerFailure(
          message: "Something went wrong while fetching events",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<AttendeeModel>>> getAllAttendees() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      return right([
        AttendeeModel(
          id: '1',
          firstName: 'Alice',
          middleName: 'M.',
          lastName: 'Kimani',
          eventId: '1',
          createdAt: '2025-07-01T10:10:00Z',
        ),
        AttendeeModel(
          id: '2',
          firstName: 'Brian',
          middleName: null,
          lastName: 'Otieno',
          eventId: '1',
          createdAt: '2025-07-01T10:15:00Z',
        ),
        AttendeeModel(
          id: '3',
          firstName: 'Cynthia',
          middleName: 'W.',
          lastName: 'Mwangi',
          eventId: '2',
          createdAt: '2025-07-05T11:20:00Z',
        ),
        AttendeeModel(
          id: '4',
          firstName: 'Daniel',
          middleName: null,
          lastName: 'Mutua',
          eventId: '3',
          createdAt: '2025-07-06T13:30:00Z',
        ),
        AttendeeModel(
          id: '5',
          firstName: 'Evelyn',
          middleName: 'A.',
          lastName: 'Kariuki',
          eventId: '4',
          createdAt: '2025-07-10T09:45:00Z',
        ),
        AttendeeModel(
          id: '6',
          firstName: 'Felix',
          middleName: 'N.',
          lastName: 'Omondi',
          eventId: '5',
          createdAt: '2025-07-12T14:55:00Z',
        ),
      ]);
    } catch (e) {
      _logger.e("Failed to get attendees", error: e);
      return left(
        ServerFailure(
          message: "Something went wrong while fetching attendees",
          error: e,
        ),
      );
    }
  }

  // Placeholder for now for this method
  Future<Either<Failure, EventModel>> getSpecificEvent(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final result = await getAllEvents();

      return result.fold((failure) => left(failure), (events) {
        final event = events.firstWhere(
          (e) => e.id == id,
          orElse: () => throw Exception("Event not found"),
        );
        return right(event);
      });
    } catch (e) {
      _logger.e("Failed to get event by ID", error: e);
      return left(
        ServerFailure(
          message: "Something went wrong while fetching the event",
          error: e,
        ),
      );
    }
  }

  // Placeholder for now for this method
  Future<Either<Failure, AttendeeModel>> getSpecificAttendee(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final result = await getAllAttendees();

      return result.fold((failure) => left(failure), (attendees) {
        final attendee = attendees.firstWhere(
          (a) => a.id == id,
          orElse: () => throw Exception("Attendee not found"),
        );
        return right(attendee);
      });
    } catch (e) {
      _logger.e("Failed to get attendee by ID", error: e);
      return left(
        ServerFailure(
          message: "Something went wrong while fetching the attendee",
          error: e,
        ),
      );
    }
  }
}
