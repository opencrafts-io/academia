import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/communities/data/models/paginated_user_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CommunityRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final String baseUrl = "https://qachirp.opencrafts.io";
  final Logger _logger = Logger();

  CommunityRemoteDatasource({required this.dioClient});

  Future<Either<Failure, CommunityData>> createCommunity({
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
        return right(CommunityData.fromJson(json));
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

  Future<Either<Failure, CommunityData>> getCommunityById({
    required String communityId,
    required String userId,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/groups/$communityId/detail/",
        data: {"user_id": userId},
        options: Options(headers: {"Accept": "application/json"}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(CommunityData.fromJson(json));
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

  Future<Either<Failure, CommunityData>> moderateCommunity({
    required String groupId,
    required String action,
    required String userId,
    required String memberId,
    required String memberName,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/groups/$groupId/moderate/",
        data: {
          "action": action,
          "user_id": userId,
          "member_id": memberId,
          "member_name": memberName,
        },
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

        return right(CommunityData.fromJson(communityJson));
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

  Future<Either<Failure, CommunityData>> joinCommunity({
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
        return right(CommunityData.fromJson(json['group']));
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
    required String userId,
    required String userName,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/groups/$groupId/leave/",
        data: {"user_id": userId, "user_name": userName},
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

  Future<Either<Failure, PaginatedUserResponse>> getCommunityMembers({
    required String communityId,
    required int page,
    required String userType,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "$baseUrl/groups/$communityId/$userType",
        queryParameters: {"page": page},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        final paginatedResponse = PaginatedUserResponse.fromJson(json);
        return right(paginatedResponse);
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while fetching users.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while fetching users.",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, CommunityData>> addCommunityGuidelines({
    required List<String> rule,
    required String communityId,
    required String userId,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "$baseUrl/groups/$communityId/rules/",
        data: {"rule": rule, "user_id": userId},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(CommunityData.fromJson(json['group']));
      } else {
        return left(
          ServerFailure(
            message: "Unexpected response while adding community guidelines.",
            error: response,
          ),
        );
      }
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred while adding community guidelines",
          error: e,
        ),
      );
    }
  }
}
