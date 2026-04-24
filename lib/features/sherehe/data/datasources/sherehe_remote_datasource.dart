import 'dart:convert';
import 'dart:io';
import 'package:academia/config/config.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/data/models/paginated_events_data_model.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
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
        "/$servicePrefix/event",
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
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected server response",
            error: response,
          ),
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
        "/$servicePrefix/event/$eventId",
      );

      if (response.statusCode == 200) {
        return right(EventData.fromJson(response.data));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected server response",
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

  Future<Either<Failure, EventData>> getEventByInvite({
    required String invite,
  }) async {
    try {
      final response = await dioClient.dio.get("/$servicePrefix/event/$invite");

      if (response.statusCode == 200) {
        return right(EventData.fromJson(response.data));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected server response",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when fetching event by Invite", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error while fetching event by Invite ", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching event",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<EventData>>> getEventByOrganizerId({
    required String organizerId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/event/organizer/$organizerId",
      );

      if (response.statusCode == 200) {
        return right(
          (response.data['data'] as List)
              .map((e) => EventData.fromJson(e))
              .toList(),
        );
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected server response",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when fetching event by Organizer ID", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error while fetching event by Organizer ID", error: e);
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred while fetching Organized events",
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
    required String eventStartDate,
    required String eventEndDate,
    required String organizerId,
    required List<String> eventGenre,
    File? eventCardImage,
    File? eventPosterImage,
    File? eventBannerImage,
    required List<TicketData> tickets,
    List<int>? institutions,
    required String scope,
    PaymentTypes? selectedPaymentType,
    String? paybillNumber,
    String? accountReference,
    String? tillNumber,
    String? sendMoneyPhoneNumber,
  }) async {
    try {
      final formData = FormData.fromMap({
        'event_name': eventName,
        'event_description': eventDescription,
        'event_url': eventUrl,
        'event_location': eventLocation,
        'start_date': eventStartDate,
        'end_date': eventEndDate,
        'organizer_id': organizerId,
        'event_genre': eventGenre,
        'tickets': jsonEncode(
          tickets.map((ticket) {
            final json = ticket.toJson();
            json.removeWhere((k, v) => v == null || v == "");
            return json;
          }).toList(),
        ),
        if (institutions != null && institutions.isNotEmpty)
          'institutions': jsonEncode(institutions),
        'scope': scope,

        if (eventCardImage != null)
          'event_card_image': await MultipartFile.fromFile(
            eventCardImage.path,
            filename: eventCardImage.path.split('/').last,
          ),
        if (eventPosterImage != null)
          'event_poster_image': await MultipartFile.fromFile(
            eventPosterImage.path,
            filename: eventPosterImage.path.split('/').last,
          ),
        if (eventBannerImage != null)
          'event_banner_image': await MultipartFile.fromFile(
            eventBannerImage.path,
            filename: eventBannerImage.path.split('/').last,
          ),
        if (selectedPaymentType == PaymentTypes.paybill) ...{
          'payment_type': 'MPESA_PAYBILL',
          if (paybillNumber?.isNotEmpty == true)
            'paybill_number': paybillNumber,
          if (accountReference?.isNotEmpty == true)
            'account_reference': accountReference,
        } else if (selectedPaymentType == PaymentTypes.till) ...{
          'payment_type': 'MPESA_TILL',
          if (tillNumber?.isNotEmpty == true) 'till_number': tillNumber,
        } else if (selectedPaymentType == PaymentTypes.sendMoney) ...{
          'payment_type': 'MPESA_SEND_MONEY',
          if (sendMoneyPhoneNumber?.isNotEmpty == true)
            'send_money_phone': sendMoneyPhoneNumber,
        } else if (selectedPaymentType == PaymentTypes.pochi) ...{
          'payment_type': 'POSHI_LA_BIASHARA',
          if (sendMoneyPhoneNumber?.isNotEmpty == true)
            'send_money_phone': sendMoneyPhoneNumber,
        },
      });
      final response = await dioClient.dio.post(
        "/$servicePrefix/event/",
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(EventData.fromJson(response.data['data']['event']));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected server response",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when creating event", error: de.response?.data);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error while creating event", error: e);
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
        "/$servicePrefix/attendee/event/$eventId",
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
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when fetching attendees",
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
      final response = await dioClient.dio.get("/$servicePrefix/attendee/$id");

      if (response.statusCode == 200) {
        return right(AttendeeData.fromJson(response.data));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when fetching attendee",
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
        "/$servicePrefix/ticket/event/$eventId",
      );

      if (response.statusCode == 200) {
        return right(
          (response.data as List).map((e) => TicketData.fromJson(e)).toList(),
        );
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when fetching ticket by event ID",
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

  Future<Either<Failure, TicketData>> getTicketByInvite({
    required String invite,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/invite/ticket/$invite",
      );

      if (response.statusCode == 200) {
        return right(TicketData.fromJson(response.data));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when fetching ticket",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when fetching ticket", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when fetching ticket", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching the ticket",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PurchaseTicketResult>> purchaseTicket({
    required String ticketId,
    required int ticketQuantity,
    required String? phoneNumber,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePrefix/purchase/",
        data: {
          "ticket_id": ticketId,
          "ticket_quantity": ticketQuantity,
          "user_phone": phoneNumber,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // PAID EVENT
        if (response.data.containsKey('trans_id')) {
          return right(
            PaidTicketInitiated(
              message: response.data['message'],
              transactionId: response.data['trans_id'],
            ),
          );
        } else {
          // FREE EVENT
          if (response.data.containsKey('message')) {
            return right(FreeTicketSuccess(message: response.data['message']));
          } else {
            return left(
              ServerFailure(
                message: "Unknown success response format",
                error: response,
              ),
            );
          }
        }
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when purchasing ticket",
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

  Future<Either<Failure, String>> confirmPayment({
    required String transId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/purchase/$transId",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(response.data['status']);
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when confirming payment",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when confirming payment", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when confirming payment", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while confirming the payment",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PaginatedResult<AttendeeData>>>
  getUserPurchasedTicketsForEvent({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/attendee/event/user/$eventId",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when getting user's ticket for event",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when getting user's ticket for event", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when getting user's ticket for event", error: e);
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred when getting user's ticket for event",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PaginatedResult<AttendeeData>>>
  getAllUserPurchasedTickets({required int page, required int limit}) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/attendee/user/attended",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when getting user's tickets",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when getting user's tickets", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when getting user's tickets", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when getting user's tickets",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<AttendeeData>>> searchUserAttendedEvents({
    required String query,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/attendee/search",
        queryParameters: {"q": query},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(
          (response.data as List).map((e) => AttendeeData.fromJson(e)).toList(),
        );
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when searching attended events",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when searching attended events", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when searching attended events", error: e);
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred when searching attended events",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, String>> validateAttendee({
    required String eventId,
    required String attendeeId,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePrefix/attendee/user/",
        data: {"eventId": eventId, "attendeeId": attendeeId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(response.data['status']);
      } else {
        _logger.e(
          "Unexpected response data when validating attendee: ${response.data}",
        );
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when validating attendee",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when validating attendee", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when validating attendee", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when validating attendee",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<EventData>>> searchEvents({
    required String query,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/event/search",
        queryParameters: {"q": query},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(
          (response.data as List).map((e) => EventData.fromJson(e)).toList(),
        );
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when searching events",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when searching events", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when searching events", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when searching events",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, DashboardStatsData>> getAttendeesAndScanners({
    required String eventId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/dashboard/events/$eventId",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(DashboardStatsData.fromJson(response.data));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when getting stats",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when getting stats", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when getting stats", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when getting stats",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<TicketStatsData>>> getDashboardTicketStats({
    required String eventId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/dashboard/tickets/$eventId",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(
          (response.data as List)
              .map((e) => TicketStatsData.fromJson(e))
              .toList(),
        );
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when getting stats",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when getting stats", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when getting stats", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when getting stats",
          error: e,
        ),
      );
    }
  }

  //for now only update ticket quantity
  Future<Either<Failure, TicketData>> updateTicket({
    required String ticketId,
    required int ticketQuantity,
  }) async {
    try {
      final response = await dioClient.dio.put(
        "/$servicePrefix/ticket/$ticketId",
        data: {"ticket_quantity": ticketQuantity},
      );

      if (response.statusCode == 200) {
        return right(TicketData.fromJson(response.data['ticket']));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when updating ticket",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when updating ticket", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when updating ticket", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred while updating ticket",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PaginatedResult<AttendeeData>>> getAllAttendees({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/dashboard/attendees/$eventId",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when getting all attendees",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when getting all attendees", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when getting all attendees", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when getting all attendees",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, ScannerData>> addEventScanner({
    required String eventId,
    required String userId,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePrefix/eventscanner/",
        data: {"event_id": eventId, "user_id": userId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(ScannerData.fromJson(response.data));
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when adding event scanner",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when adding event scanner", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when adding event scanner", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when adding event scanner",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PaginatedResult<ScannerData>>> getEventScanners({
    required String eventId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/eventscanner/event/$eventId",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(
          PaginatedResult(
            results: (response.data['data'] as List)
                .map((e) => ScannerData.fromJson(e))
                .toList(),
            next: response.data['nextPage']?.toString(),
            previous: response.data['previousPage']?.toString(),
            currentPage: response.data['currentPage'],
          ),
        );
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when getting all event scanners",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when getting all event scanners", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when getting all event scanners", error: e);
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred when getting all event scanners",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, String>> deleteEventScanner({
    required String scannerId,
  }) async {
    try {
      final response = await dioClient.dio.delete(
        "/$servicePrefix/eventscanner/$scannerId",
      );

      if (response.statusCode == 200) {
        return right(response.data['message']);
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when deleting event scanner",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when deleting event scanner", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when deleting event scanner", error: e);
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred when deleting the event scanner",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, String>> getEventScannerByUserId({
    required String eventId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/eventscanner/user/$eventId",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(response.data['message']);
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when getting event scanner by user id",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e(
        "DioException when getting event scanner by user id",
        error: de,
      );
      return handleDioError(de);
    } catch (e) {
      _logger.e(
        "Unknown error when getting event scanner by user id",
        error: e,
      );
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred when getting event scanner by user id",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<ShereheUserData>>> searchUsersByUsername({
    required String query,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/user/search",
        queryParameters: {"q": query},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(
          (response.data['data'] as List)
              .map((e) => ShereheUserData.fromJson(e))
              .toList(),
        );
      } else {
        return left(
          ServerFailure(
            message:
                response.data['message'] ??
                response.data["error"] ??
                "Unexpected response when searching users",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      _logger.e("DioException when searching users", error: de);
      return handleDioError(de);
    } catch (e) {
      _logger.e("Unknown error when searching users", error: e);
      return left(
        ServerFailure(
          message: "An unexpected error occurred when searching users",
          error: e,
        ),
      );
    }
  }
}
