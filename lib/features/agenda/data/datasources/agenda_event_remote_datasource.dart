import 'package:academia/core/data/paginated_result.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AgendaEventRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final String servicePath;

  AgendaEventRemoteDatasource({
    required this.dioClient,
    this.servicePath = "qa-keepup",
  });

  Future<Either<Failure, PaginatedResult<AgendaEventData>>>
  refreshAgendaEvents({int page = 0, int pageSize = 100}) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePath/agenda/&sync=true",
        queryParameters: {"page": page, "pageSize": pageSize},
      );
      if (response.statusCode == 200) {
        return Right(
          PaginatedResult(
            results: ((response.data["results"] as List)
                .map((e) => AgendaEventData.fromJson(e))
                .toList()),
            currentPage: page,
            next: response.data["next"],
            previous: response.data["previous"],
          ),
        );
      }
      return left(NetworkFailure(error: "", message: ""));
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Time keeps on slippin' into the future" - Steve Miller Band
              "Time keeps on slippin' into the future! We couldn't sync your calendar right now. The cosmic forces are having a moment!",
        ),
      );
    }
  }

  Future<Either<Failure, AgendaEventData>> createAgendaEvent(
    AgendaEventData agenda,
  ) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePath/agenda/add",
        data: agenda.toJson(),
      );
      if (response.statusCode == 201) {
        return Right(AgendaEventData.fromJson(response.data));
      }
      return Left(
        NetworkFailure(
          // "I can't get no satisfaction" - Rolling Stones
          message: "I can't get no satisfaction! Something went wrong while creating your event. The server's not feeling it today!",
          error: "",
        ),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Don't stop believin'" - Journey
              "Don't stop believin'! We couldn't create your agenda event right now, but hold on to that feeling and try again!",
        ),
      );
    }
  }

  Future<Either<Failure, AgendaEventData>> updateAgendaEvent(
    AgendaEventData agenda,
  ) async {
    try {
      final response = await dioClient.dio.put(
        "/$servicePath/agenda/update/${agenda.id}",
        data: agenda.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(AgendaEventData.fromJson(response.data));
      }
      return Left(
        NetworkFailure(
          // "Changes" - David Bowie
          message: "Changes! We couldn't make those changes happen. Even Ziggy Stardust would be confused!",
          error: "",
        ),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: 
              // "Should I stay or should I go?" - The Clash
              "Should I stay or should I go? We couldn't update your agenda event. The system is having an identity crisis!",
        ),
      );
    }
  }

  Future<Either<Failure, AgendaEventData>> deleteAgendaEventData(
    AgendaEventData agenda,
  ) async {
    try {
      final response = await dioClient.dio.delete(
        "/$servicePath/agenda/delete/${agenda.id}",
        data: agenda.toJson(),
      );
      if (response.statusCode == 204) {
        return Right(agenda);
      }
      return Left(
        NetworkFailure(
          // "Another one bites the dust" - Queen
          message: "Another one bites the dust! We couldn't delete that event. It's being stubborn like a rock!",
          error: "",
        ),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: 
              // "I will survive" - Gloria Gaynor
              "I will survive! That event is refusing to be deleted. It's got survival instincts!",
        ),
      );
    }
  }
}
