import 'dart:io';
import 'package:academia/config/config.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/models/paginated_events_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:academia/core/core.dart';

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
        "https://qasherehe.opencrafts.io/event",
        // "$servicePrefix/event",
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

  Future<Either<Failure, EventData>> getEventById({
    required String eventId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "https://qasherehe.opencrafts.io/event/$eventId",
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

  Future<Either<Failure, EventData>> createEvent({
    required String eventName,
    required String eventDescription,
    String? eventUrl,
    required String eventLocation,
    required String eventDate,
    required String organizerId,
    required List<String> eventGenre,
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
        "https://qasherehe.opencrafts.io/event/",
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

  Future<Either<Failure, PaginatedResult<AttendeeData>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "https://qasherehe.opencrafts.io/attendee/event/$eventId",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        return right(
          PaginatedResult(
            results: (response.data['data'] as List)
                .map((e) => AttendeeData.fromJson(e))
                .toList(),
            next: response.data['nextPage']?.toString(),
            previous: response.data['previousPage']?.toString(),
            currentPage: response.data['currentPage'],
          ),
        );
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

  Future<Either<Failure, AttendeeData>> getAttendeeByID(String id) async {
    try {
      final response = await dioClient.dio.get(
        "https://qasherehe.opencrafts.io/attendee/$id",
      );

      if (response.statusCode == 200) {
        return right(AttendeeData.fromJson(response.data));
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

  Future<Either<Failure, List<TicketData>>> getTicketByEventId(
    String eventId,
  ) async {
    try {
      final response = await dioClient.dio.get(
        "https://qasherehe.opencrafts.io/ticket/event/$eventId",
      );

      if (response.statusCode == 200) {
        return right(
          (response.data as List).map((e) => TicketData.fromJson(e)).toList(),
        );
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response when fetching ticket by event ID",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e(
        "DioException when fetching ticket for event $eventId",
        error: de,
      );
      return handleDioError(de);
    } catch (e) {
      _logger.e(
        "Unknown error when fetching ticket for event $eventId",
        error: e,
      );
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching the ticket",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, AttendeeData>> purchaseTicket({
    required String ticketId,
    required int ticketQuantity,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "https://qasherehe.opencrafts.io/purchase/",
        data: {"ticket_id": ticketId, "ticket_quantity": ticketQuantity},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(AttendeeData.fromJson(response.data['attendee']));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response when purchasing ticket",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when purchasing ticket", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when purchasing ticket", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while purchasing the ticket",
          error: e,
        ),
      );
    }
  }
}
