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
import '../../domain/entities/event.dart';
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
        // "https://qasherehe.opencrafts.io/events/getAllEvents",
        "/$servicePrefix/events/getAllEvents",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        final List<EventData> events = (response.data['data'] as List)
            .map((e) => EventData.fromJson(e))
            .toList();

        final int? nextPage = response.data['nextPage'];

        return right(PaginatedEventsData(events: events, nextPage: nextPage));
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

  Future<Either<Failure, EventData>> getSpecificEvent(String id) async {
    try {
      final response = await dioClient.dio.get(
        // 'https://qasherehe.opencrafts.io/events/getEventById/$id',
        "/$servicePrefix/events/getEventById/$id",
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> eventJson = Map<String, dynamic>.from(
          response.data['result'],
        );
        if (eventJson['organizer_id'] is String) {
          eventJson['organizer_id'] =
              int.tryParse(eventJson['organizer_id'] as String) ?? 0;
        }
        if (eventJson['number_of_attendees'] is String) {
          eventJson['number_of_attendees'] =
              int.tryParse(eventJson['number_of_attendees'] as String) ?? 0;
        }

        return right(EventData.fromJson(eventJson));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected server response while fetching event.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when fetching event $id", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error while fetching event $id", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching the event",
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

  Future<Either<Failure, Unit>> createEvent(
    Event event, {
    File? eventImage,
    File? bannerImage,
    File? cardImage,
  }) async {
    try {
      if (eventImage == null) {
        _logger.w("createEvent called without a required poster image file.");
        return left(
          ServerFailure(
            message: "No poster image provided for event creation.",
            error: "Poster image file is required",
          ),
        );
      }
      if (bannerImage == null) {
        _logger.w("createEvent called without a required banner image file.");
        return left(
          ServerFailure(
            message: "No banner image provided for event creation.",
            error: "Banner image file is required",
          ),
        );
      }
      if (cardImage == null) {
        _logger.w("createEvent called without a required card image file.");
        return left(
          ServerFailure(
            message: "No card image provided for event creation.",
            error: "Card image file is required",
          ),
        );
      }
      Map<String, dynamic> eventDataMap = {
        'name': event.name,
        'description': event.description,
        'date': event.date,
        'time': event.time,
        'genre': event.genre.join(','),
        'location': event.location,
        'organizer': event.organizer,
        'organizer_id': event.organizerId,
        'url': event.url,
      };
      final FormData formData = FormData.fromMap(eventDataMap);
      String posterFileName;
      try {
        posterFileName = eventImage.path.split('/').last;
        if (posterFileName.isEmpty) {
          throw FormatException("Extracted poster filename is empty");
        }
      } catch (e) {
        _logger.w(
          "Could not extract poster filename from path '${eventImage.path}'. Error: $e. Generating default filename.",
        );
        String extension = '.jpg';
        try {
          final pathParts = eventImage.path.split('.');
          if (pathParts.length > 1) {
            extension = '.${pathParts.last}';
          }
        } catch (extError) {
          _logger.d(
            "Could not determine poster file extension, using default .jpg. Error: $extError",
          );
        }
        posterFileName =
            'event_poster_${DateTime.now().millisecondsSinceEpoch}$extension';
      }
      _logger.d("Using poster filename for upload: $posterFileName");
      formData.files.add(
        MapEntry(
          'poster',
          await MultipartFile.fromFile(
            eventImage.path,
            filename: posterFileName,
          ),
        ),
      );
      String bannerFileName;
      try {
        bannerFileName = bannerImage.path.split('/').last;
        if (bannerFileName.isEmpty) {
          throw FormatException("Extracted banner filename is empty");
        }
      } catch (e) {
        _logger.w(
          "Could not extract banner filename from path '${bannerImage.path}'. Error: $e. Generating default filename.",
        );
        String extension = '.jpg';
        try {
          final pathParts = bannerImage.path.split('.');
          if (pathParts.length > 1) {
            extension = '.${pathParts.last}';
          }
        } catch (extError) {
          _logger.d(
            "Could not determine banner file extension, using default .jpg. Error: $extError",
          );
        }
        bannerFileName =
            'event_banner_${DateTime.now().millisecondsSinceEpoch}$extension';
      }
      _logger.d("Using banner filename for upload: $bannerFileName");
      formData.files.add(
        MapEntry(
          'banner',
          await MultipartFile.fromFile(
            bannerImage.path,
            filename: bannerFileName,
          ),
        ),
      );
      String cardFileName;
      try {
        cardFileName = cardImage.path.split('/').last;
        if (cardFileName.isEmpty) {
          throw FormatException("Extracted card filename is empty");
        }
      } catch (e) {
        _logger.w(
          "Could not extract card filename from path '${cardImage.path}'. Error: $e. Generating default filename.",
        );
        String extension = '.jpg';
        try {
          final pathParts = cardImage.path.split('.');
          if (pathParts.length > 1) {
            extension = '.${pathParts.last}';
          }
        } catch (extError) {
          _logger.d(
            "Could not determine card file extension, using default .jpg. Error: $extError",
          );
        }
        cardFileName =
            'event_card_${DateTime.now().millisecondsSinceEpoch}$extension';
      }
      _logger.d("Using card filename for upload: $cardFileName");
      formData.files.add(
        MapEntry(
          'event_card_image',
          await MultipartFile.fromFile(cardImage.path, filename: cardFileName),
        ),
      );

      // final String endpointUrl =
      //     "https://qasherehe.opencrafts.io/events/createEvent";
      //
      final String endpointUrl = "/$servicePrefix/events/createEvent";

      _logger.i("Sending event creation request to: $endpointUrl");
      _logger.d("Event data (non-file): $eventDataMap");
      final response = await dioClient.dio.post(endpointUrl, data: formData);
      _logger.i("Event creation response status: ${response.statusCode}");
      _logger.d("Event creation response data: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = response.data['message'] ?? 'Event created';
        _logger.i("Event created successfully: $message");
        return right(unit);
      } else {
        _logger.e(
          "Server error creating event. Status: ${response.statusCode}, Response: ${response.data}",
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
        "DioException when creating event",
        error: de,
        stackTrace: de.stackTrace,
      );
      return handleDioError(de);
    } catch (e, stackTrace) {
      _logger.e(
        "Unexpected error while creating event",
        error: e,
        stackTrace: stackTrace,
      );
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred while creating the event: ${e.toString()}",
          error: e.toString(),
        ),
      );
    }
  }
}
