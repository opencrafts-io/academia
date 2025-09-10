import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/features/communities/data/models/community_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CommunityRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final String baseUrl = "https://qachirp.opencrafts.io";
  final Logger _logger = Logger();

  CommunityRemoteDatasource({required this.dioClient});

  Future<Either<Failure, CommunityModel>> createCommunity({
    required String name,
    required String description,
    required bool isPublic,
    required String userId,
    required String userName,
    required String userEmail,
    String? logoPath,
    String? bannerPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "description": description,
        "is_public": isPublic.toString(), // backend expects string for booleans
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        if (logoPath != null)
          "logo": await MultipartFile.fromFile(
            logoPath,
            filename: logoPath.split('/').last,
          ),
        if (bannerPath != null)
          "banner": await MultipartFile.fromFile(
            bannerPath,
            filename: bannerPath.split('/').last,
          ),
      });

      final response = await dioClient.dio.post(
        "$baseUrl/groups/create/",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(CommunityModel.fromJson(json));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while creating community.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while creating community",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, CommunityModel>> getCommunityById(String id) async {
    try {
      final response = await dioClient.dio.get(
        "$baseUrl/groups/$id",
        options: Options(headers: {"Accept": "application/json"}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(CommunityModel.fromJson(json));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while fetching community",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching community",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, CommunityModel>> moderateCommunity({
    required String groupId,
    required String action,
    required String userId,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/groups/$groupId/moderate/",
        data: {"action": action, "user_id": userId},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      _logger.d("Moderate response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        final communityJson = Map<String, dynamic>.from(json["group"]);

        return right(CommunityModel.fromJson(communityJson));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while moderating community.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while moderating community",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, CommunityModel>> joinCommunity({
    required String groupId,
    required String userId,
    required String userName,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/groups/$groupId/join/",
        data: {"user_id": userId, "user_name": userName},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(CommunityModel.fromJson(json['group']));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while joining community.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while joining community",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, String>> leaveCommunity({
    required String groupId,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/groups/$groupId/leave/",
        options: Options(headers: {"Accept": "application/json"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(json["message"] as String);
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while leaving community.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while leaving community",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, String>> deleteCommunity({
    required String groupId,
    required String userId,
  }) async {
    try {
      final response = await dioClient.dio.delete(
        "$baseUrl/groups/$groupId/delete/",
        queryParameters: {"user_id": userId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(json["message"] as String);
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while deleting community.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while deleting community",
          error: e,
        ),
      );
    }
  }
}
