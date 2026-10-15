import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Contract for poll voting/voter-listing calls.
///
/// Two implementations exist: [ChirpPollRemoteDataSource] (real, against
/// docs/api/chirp-polls-contract.md) and `MockPollRemoteDataSource`
/// (in-memory, used until the backend ships). DI decides which one is used.
abstract class PollRemoteDataSource {
  /// Replace the caller's selection for [pollId] with [optionIds].
  Future<Either<Failure, PollData>> vote({
    required int pollId,
    required String voterId,
    required List<int> optionIds,
  });

  /// Remove all of the caller's selections for [pollId].
  Future<Either<Failure, PollData>> retractVote({
    required int pollId,
    required String voterId,
  });

  Future<Either<Failure, PaginatedData<PollVoterData>>> getVoters({
    required int pollId,
    int? optionId,
    required int page,
    required int pageSize,
  });
}

class ChirpPollRemoteDataSource
    with DioErrorHandler, ConnectivityChecker
    implements PollRemoteDataSource {
  final DioClient dioClient;
  final FlavorConfig flavor;
  late String servicePrefix;
  final Logger _logger = Logger();

  ChirpPollRemoteDataSource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePrefix = "chirp";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-chirp';
    } else {
      servicePrefix = "dev-chirp";
    }
  }

  @override
  Future<Either<Failure, PollData>> vote({
    required int pollId,
    required String voterId,
    required List<int> optionIds,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.post(
        '/$servicePrefix/polls/$pollId/vote/',
        data: {'voter_id': voterId, 'option_ids': optionIds},
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return right(PollData.fromJson(Map<String, dynamic>.from(res.data)));
      }

      return left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      _logger.e('[vote] DioException: ${e.response?.statusCode}');
      return handleDioError(e);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while voting",
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PollData>> retractVote({
    required int pollId,
    required String voterId,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.delete(
        '/$servicePrefix/polls/$pollId/vote/',
        data: {'voter_id': voterId},
      );

      if (res.statusCode == 200) {
        return right(PollData.fromJson(Map<String, dynamic>.from(res.data)));
      }

      return left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      _logger.e('[retractVote] DioException: ${e.response?.statusCode}');
      return handleDioError(e);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while retracting your vote",
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PaginatedData<PollVoterData>>> getVoters({
    required int pollId,
    int? optionId,
    required int page,
    required int pageSize,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.get(
        '/$servicePrefix/polls/$pollId/voters/',
        queryParameters: {
          'option_id': ?optionId,
          'page': page,
          'page_size': pageSize,
        },
      );

      if (res.statusCode != 200 || res.data['results'] is! List) {
        return left(
          NetworkFailure(message: "Unexpected response", error: res.data),
        );
      }

      return right(
        PaginatedData(
          results: (res.data['results'] as List)
              .map((e) => PollVoterData.fromJson(Map<String, dynamic>.from(e)))
              .toList(),
          count: res.data['count'],
          next: res.data['next'],
          previous: res.data['previous'],
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while loading voters",
          error: e,
        ),
      );
    }
  }
}
