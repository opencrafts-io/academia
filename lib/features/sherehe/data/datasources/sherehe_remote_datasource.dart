import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:academia/core/network/network.dart';
import '../../../../core/core.dart';

class ShereheRemoteDataSource with DioErrorHandler {
  final DioClient dioClient;
  final Logger _logger = Logger();

  ShereheRemoteDataSource({required this.dioClient});

  Future<Either<Failure, List<EventData>>> getAllEvents({
    required int page,
    required int limit,
  }) async {
    try {
      // Giving full url for now since flavour's basurl at the moment is verisafe's url
      final response = await dioClient.dio.get(
        "https://qasherehe.opencrafts.io/events/getAllEvents",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        final List<EventData> events = (response.data['data'] as List)
            .map((e) => EventData.fromJson(e))
            .toList();

        return right(events);
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
      final response = await dioClient.dio.get('https://qasherehe.opencrafts.io/events/getEventById/$id');

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
      final response = await dioClient.dio.get('https://qasherehe.opencrafts.io/attendees/$id');

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
}
