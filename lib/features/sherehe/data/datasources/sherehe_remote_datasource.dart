import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../core/core.dart';
import 'package:academia/core/network/network.dart';
import '../data.dart';

class ShereheRemoteDataSource with DioErrorHandler {
  final DioClient dioClient;
  final Logger _logger = Logger();

  ShereheRemoteDataSource({required this.dioClient});

  Future<Either<Failure, List<EventModel>>> getAllEvents({
    required int page,
    required int limit,
  }) async {
    try {
      // Giving full url for now since flavour's basurl at the moment is verisafe's url
      final response = await dioClient.dio.get(
        "http://127.0.0.1:3000/events/getAllEvents",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        final List<EventModel> events = (response.data['data'] as List)
            .map((e) => EventModel.fromJson(e))
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

  Future<Either<Failure, List<AttendeeModel>>> getAttendeesByEventId({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "http://127.0.0.1:3000/attendees/event/$eventId",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        final List<AttendeeModel> attendees = (response.data['data'] as List)
            .map((e) => AttendeeModel.fromJson(e))
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

  Future<Either<Failure, EventModel>> getSpecificEvent(String id) async {
    try {
      final response = await dioClient.dio.get('http://127.0.0.1:3000/events/getEventById/$id');

      if (response.statusCode == 200) {
        return right(EventModel.fromJson(response.data['result']));
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

  Future<Either<Failure, AttendeeModel>> getSpecificAttendee(String id) async {
    try {
      final response = await dioClient.dio.get('http://127.0.0.1:3000/attendees/$id');

      if (response.statusCode == 200) {
        return right(AttendeeModel.fromJson(response.data['result']));
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
