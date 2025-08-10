import 'dart:io';
import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/models/paginated_events_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:academia/core/network/network.dart';
import '../../../../core/core.dart';
import '../../domain/entities/event.dart';

class ShereheRemoteDataSource with DioErrorHandler {
  final DioClient dioClient;
  final String servicePrefix;
  final Logger _logger = Logger();

  ShereheRemoteDataSource({
    required this.dioClient,
    this.servicePrefix = "qa-sherehe",
  });

  Future<Either<Failure, PaginatedEventsData>> getAllEvents({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "https://qasherehe.opencrafts.io/events/getAllEvents",
        // "/$servicePrefix/events/getAllEvents",
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
        "https://qasherehe.opencrafts.io/attendees/event/$eventId",
        // "/$servicePrefix/attendees/event/$eventId",
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
        'https://qasherehe.opencrafts.io/events/getEventById/$id',
        // "/$servicePrefix/events/getEventById/$id",

      );

      if (response.statusCode == 200) {
        return right(EventData.fromJson(response.data['result']));
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
        'https://qasherehe.opencrafts.io/attendees/$id',
        // "/$servicePrefix//attendees/$id",
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
  Future<Either<Failure, Unit>> createEvent(Event event, {File? eventImage}) async {
    try {
      if (eventImage == null) {
        _logger.w("createEvent called without a required image file.");
        return left(ServerFailure(
            message: "No image provided for event creation.",
            error: "Image file is required"));
      }

      Map<String, dynamic> eventDataMap = {
        'name': event.name,
        'description': event.description,
        'date': event.date,
        'time': event.time,
        'genre': event.genre.join(','),
        'location': event.location,
        'url': event.url,
        'organizer': event.organizer,
        'organizer_id': event.organizerId,
      };

      final FormData formData = FormData.fromMap(eventDataMap);

      String fileName;
      try {
        fileName = eventImage.path.split('/').last;
        if (fileName.isEmpty) {
          throw FormatException("Extracted filename is empty");
        }
      } catch (e) {
        _logger.w("Could not extract filename from path '${eventImage.path}'. Error: $e. Generating default filename.");
        String extension = '.jpg';
        try {
          final pathParts = eventImage.path.split('.');
          if (pathParts.length > 1) {
            extension = '.${pathParts.last}';
          }
        } catch (extError) {
          _logger.d("Could not determine file extension, using default .jpg. Error: $extError");
        }
        fileName = 'event_image_${DateTime.now().millisecondsSinceEpoch}$extension';
      }

      _logger.d("Using filename for upload: $fileName");

      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(eventImage.path, filename: fileName),
      ));

      final String endpointUrl = "https://qasherehe.opencrafts.io/events/createEvent";

      _logger.i("Sending event creation request to: $endpointUrl");
      _logger.d("Event data (non-file): $eventDataMap");

      final response = await dioClient.dio.post(
        endpointUrl,
        data: formData,
      );

      _logger.i("Event creation response status: ${response.statusCode}");
      _logger.d("Event creation response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = response.data['message'] ?? 'Event created';
        _logger.i("Event created successfully: $message");
        return right(unit);
      } else {
        _logger.e("Server error creating event. Status: ${response.statusCode}, Response: ${response.data}");
        String errorMessage = response.data['message'] ?? 'Unknown server error';
        _logger.e("Server error message: $errorMessage");
        return left(
          ServerFailure(
            message: "Server error: $errorMessage (Status: ${response.statusCode})",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when creating event", error: de, stackTrace: de.stackTrace);
      return handleDioError(de);
    } catch (e, stackTrace) {
      _logger.e("Unexpected error while creating event", error: e, stackTrace: stackTrace);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while creating the event: ${e.toString()}",
          error: e.toString(),
        ),
      );
    }
  }
}