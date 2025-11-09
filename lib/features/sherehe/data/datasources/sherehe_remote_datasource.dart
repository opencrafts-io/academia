import 'dart:io';
import 'package:academia/config/config.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/models/paginated_events_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:academia/core/network/network.dart';
import '../../../../core/core.dart';
import '../../domain/entities/attendee.dart';
import 'dart:math';

class ShereheRemoteDataSource with DioErrorHandler {
  final DioClient dioClient;
  late String servicePrefix;
  final Logger _logger = Logger();
  final FlavorConfig flavor;

  ShereheRemoteDataSource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePrefix = "sherehe";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-sherehe';
    } else {
      servicePrefix = "dev-sherehe";
    }
  }

  Future<Either<Failure, PaginatedEventsData>> getAllEvents({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "http://192.168.100.128:3001/event",
        // "/$servicePrefix/events/getAllEvents",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        return right(
          PaginatedEventsData(
            events: (response.data['data'] as List)
                .map((e) => EventData.fromJson(e))
                .toList(),
            nextPage: response.data['nextPage'],
            previousPage: response.data['previousPage'],
            totalEvents: response.data['totalEvents'],
          ),
        );
      } else {
        return left(
          ServerFailure(message: "Unexpected server response", error: response),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when fetching events", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error while fetching events", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching events",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<AttendeeData>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        // "https://qasherehe.opencrafts.io/attendees/event/$eventId",
        "/$servicePrefix/attendees/event/$eventId",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        final List<AttendeeData> attendees = (response.data['data'] as List)
            .map((e) => AttendeeData.fromJson(e))
            .toList();

        return right(attendees);
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response when fetching attendees",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e(
        "DioException when fetching attendees for event $eventId",
        error: de,
      );
      return handleDioError(de);
    } catch (e) {
      _logger.e(
        "Unknown error when fetching attendees for event $eventId",
        error: e,
      );
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching attendees",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, EventData>> getEventById({
    required String eventId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "http://192.168.100.128:3001/event/$eventId",
      );

      if (response.statusCode == 200) {
        return right(EventData.fromJson(response.data));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected server response: ${response.statusCode}",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when fetching event by ID", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error while fetching event by ID", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching event",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, AttendeeData>> getSpecificAttendee(String id) async {
    try {
      final response = await dioClient.dio.get(
        // 'https://qasherehe.opencrafts.io/attendees/$id',
        "/$servicePrefix/attendees/$id",
      );

      if (response.statusCode == 200) {
        return right(AttendeeData.fromJson(response.data['result']));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response when fetching attendee",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when fetching attendee $id", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when fetching attendee $id", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching the attendee",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, AttendeeData>> createAttendee(
    Attendee attendee,
  ) async {
    final String fullTempId =
        'temp_${DateTime.now().millisecondsSinceEpoch}_${attendee.eventId}_${attendee.firstName}_${attendee.lastName}_${attendee.email}';
    final String safeTempId = fullTempId.substring(
      0,
      min(fullTempId.length, 50),
    );
    try {
      final Map<String, dynamic> attendeeData = {
        'first_name': attendee.firstName,
        'middle_name': attendee.middleName,
        'last_name': attendee.lastName,
        'event_id': attendee.eventId,
        'email': attendee.email,
      };

      // final String endpointUrl = "https://qasherehe.opencrafts.io/attendees/";
      final String endpointUrl = "/$servicePrefix/attendees/";
      _logger.i("Sending attendee creation request to: $endpointUrl");
      _logger.d("Attendee data: $attendeeData");

      final response = await dioClient.dio.post(
        endpointUrl,
        data: attendeeData,
      );

      _logger.i("Attendee creation response status: ${response.statusCode}");
      _logger.d("Attendee creation response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic> &&
            response.data['message'] == "Attendee created successfully") {
          _logger.i(
            "Attendee created successfully on server (Status 201/200).",
          );
          final fakeAttendeeData = AttendeeData(
            id: safeTempId,
            firstName: attendee.firstName,
            middleName: attendee.middleName,
            lastName: attendee.lastName,
            eventId: attendee.eventId,
            email: attendee.email,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          _logger.w(
            "Attendee creation successful, created local placeholder data based on sent data.",
          );
          return right(fakeAttendeeData);
        } else {
          _logger.w(
            "Attendee creation successful (status ${response.statusCode}) but response body format unexpected: ${response.data}",
          );
          return left(
            ServerFailure(
              message:
                  "Attendee created on server, but the response format was unexpected.",
              error: "Response data: ${response.data.toString()}",
            ),
          );
        }
      } else {
        _logger.e(
          "Server error creating attendee. Status: ${response.statusCode}, Response: ${response.data}",
        );
        String errorMessage =
            response.data['message'] ?? 'Unknown server error';
        _logger.e("Server error message: $errorMessage");
        return left(
          ServerFailure(
            message:
                "Server error: $errorMessage (Status: ${response.statusCode})",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e(
        "DioException when creating attendee",
        error: de,
        stackTrace: de.stackTrace,
      );
      return handleDioError(de);
    } catch (e, stackTrace) {
      _logger.e(
        "Unexpected error while creating attendee",
        error: e,
        stackTrace: stackTrace,
      );
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred while creating the attendee: ${e.toString()}",
          error: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, EventData>> createEvent({
    required String eventName,
    required String eventDescription,
    String? eventUrl,
    required String eventLocation,
    required String eventDate,
    required String organizerId,
    required String eventGenre,
    required File eventCardImage,
    required File eventPosterImage,
    required File eventBannerImage,
    required List<TicketData> tickets,
  }) async {
    try {
      // Prepare multipart form data
      final formData = FormData.fromMap({
        'event_name': eventName,
        'event_description': eventDescription,
        if (eventUrl != null) 'event_url': eventUrl,
        'event_location': eventLocation,
        'event_date': eventDate,
        // 'organizer_id': organizerId,// to be commented out later
        'organizer_id':
            "b19a3c82-1d5e-4f77-95cb-5b5196ad06c8", // temporarily hardcoded
        'event_genre': eventGenre,
        'tickets': tickets.map((ticket) {
          final json = ticket.toJson();
          json.removeWhere((key, value) => value == null || value == "");
          return json;
        }).toList(),

        'event_card_image': await MultipartFile.fromFile(
          eventCardImage.path,
          filename: eventCardImage.path.split('/').last,
        ),
        'event_poster_image': await MultipartFile.fromFile(
          eventPosterImage.path,
          filename: eventPosterImage.path.split('/').last,
        ),
        'event_banner_image': await MultipartFile.fromFile(
          eventBannerImage.path,
          filename: eventBannerImage.path.split('/').last,
        ),
      });

      // Send request
      final response = await dioClient.dio.post(
        "http://192.168.100.128:3001/event/",
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );

      // Handle success
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(EventData.fromJson(response.data['event']));
      } else {
        return left(
          ServerFailure(
            message:
                "Unexpected server response: ${response.statusCode} ${response.statusMessage}",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while creating the event",
          error: e,
        ),
      );
    }
  }
}
