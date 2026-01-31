import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class InteractionsRemoteDataSource with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  final FlavorConfig flavor;
  late String servicePrefix;
  final Logger _logger = Logger();

  InteractionsRemoteDataSource({
    required this.dioClient,
    required this.flavor,
  }) {
    if (flavor.isProduction) {
      servicePrefix = "chirp";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-chirp';
    } else {
      servicePrefix = "dev-chirp";
    }
  }

  // BLOCK USER
  Future<Either<Failure, BlockData>> blockUser(String userId) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.post(
        '/$servicePrefix/interactions/blocks/',
        data: {'blocked_user': userId, 'block_type': 'user'},
      );


      if (res.statusCode == 201 && res.data != null) {
        return Right(BlockData.fromJson(res.data));
      }

      return Left(
        NetworkFailure(
          message: res.data['error'] ?? 'Failed to block user',
          error: res.data,
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      _logger.e("Error blocking user: $e");
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while blocking user",
          error: e,
        ),
      );
    }
  }

  // BLOCK COMMUNITY
  Future<Either<Failure, BlockData>> blockCommunity(int communityId) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.post(
        '/$servicePrefix/interactions/blocks/',
        data: {'blocked_community': communityId, 'block_type': 'community'},
      );

      if (res.statusCode == 201 && res.data != null) {
        return Right(BlockData.fromJson(res.data));
      }

      return Left(
        NetworkFailure(
          message: res.data['error'] ?? 'Failed to block community',
          error: res.data,
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      _logger.e("Error blocking community: $e");
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while blocking community",
          error: e,
        ),
      );
    }
  }

  // UNBLOCK BY ID
  Future<Either<Failure, void>> unblockById(int blockId) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.delete(
        '/$servicePrefix/interactions/unblocks/$blockId/',
      );


      if (res.statusCode == 204 || res.statusCode == 200) {
        return const Right(null);
      }

      return Left(
        NetworkFailure(
          message: res.data['error'] ?? 'Failed to unblock',
          error: res.data,
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      _logger.e("Error unblocking by ID: $e");
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while unblocking",
          error: e,
        ),
      );
    }
  }

  // GET BLOCKS
  Future<Either<Failure, List<BlockData>>> getBlocks({String? type}) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.get(
        '/$servicePrefix/interactions/blocks/',
        queryParameters: type != null ? {'block_type': type} : null,
      );


      if (res.statusCode == 200 && res.data['results'] is List) {
        final blocks = (res.data['results'] as List)
            .map((json) => BlockData.fromJson(json))
            .toList();
        return Right(blocks);
      }

      return Left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      _logger.e("Error getting blocks: $e");
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while getting blocks",
          error: e,
        ),
      );
    }
  }

  // CHECK BLOCK STATUS
  Future<Either<Failure, bool>> checkBlockStatus({
    required String entityType,
    required String entityId,
  }) async {
    return const Right(false);
  }

  // REPORT USER
  Future<Either<Failure, ReportData>> reportUser({
    required String userId,
    required String reason,
  }) async {
    return _submitReport(
      data: {'reported_user': userId, 'report_type': 'user', 'reason': reason},
    );
  }

  // REPORT POST
  Future<Either<Failure, ReportData>> reportPost({
    required int postId,
    required String reason,
  }) async {
    return _submitReport(
      data: {'reported_post': postId, 'report_type': 'post', 'reason': reason},
    );
  }

  // REPORT COMMENT
  Future<Either<Failure, ReportData>> reportComment({
    required int commentId,
    required String reason,
  }) async {
    return _submitReport(
      data: {
        'reported_comment': commentId,
        'report_type': 'comment',
        'reason': reason,
      },
    );
  }

  // REPORT COMMUNITY
  Future<Either<Failure, ReportData>> reportCommunity({
    required int communityId,
    required String reason,
  }) async {
    return _submitReport(
      data: {
        'reported_community': communityId,
        'report_type': 'community',
        'reason': reason,
      },
    );
  }

  // SUBMIT REPORT
  Future<Either<Failure, ReportData>> _submitReport({
    required Map<String, dynamic> data,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.post(
        '/$servicePrefix/interactions/reports/',
        data: data,
      );

      if (res.statusCode == 201 && res.data != null) {
        return Right(ReportData.fromJson(res.data));
      }

      return Left(
        NetworkFailure(
          message: res.data['error'] ?? 'Failed to submit report',
          error: res.data,
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      _logger.e("Error submitting report: $e");
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while submitting report",
          error: e,
        ),
      );
    }
  }
}
