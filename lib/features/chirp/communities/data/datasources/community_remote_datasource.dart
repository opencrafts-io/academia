import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/connectivity_checker.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:academia/features/chirp/communities/data/models/paginated_user_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CommunityRemoteDatasource with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  late String servicePrefix;
  final Logger _logger = Logger();
  final FlavorConfig flavor;

  CommunityRemoteDatasource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePrefix = "chirp";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-chirp';
    } else {
      servicePrefix = "dev-chirp";
    }
  }

  Future<Either<Failure, CommunityData>> createCommunity({
    required CommunityData community,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final requestData = community.toJson();
      requestData["id"] = null;
      requestData["creator"] = requestData["creator_id"];
      requestData.remove("creator_id");
      if (requestData["profile_picture"] != null) {
        requestData["profile_picture"] = await MultipartFile.fromFile(
          requestData["profile_picture"].toString(),
          filename: requestData["profile_picture"].toString().split("/").last,
        );
      }
      if (requestData["banner"] != null) {
        requestData["banner"] = await MultipartFile.fromFile(
          requestData["banner"].toString(),
          filename: requestData["banner"].toString().split("/").last,
        );
      }
      final formData = FormData.fromMap(requestData);

      final response = await dioClient.dio.post(
        "/$servicePrefix/community/create/",
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          response.data,
        );
        return right(CommunityData.fromJson(json));
      }
      throw ("Programming error");
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.get(
        "/$servicePrefix/community/$communityId/details",
        // data: {"user_id": userId},
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.post(
        "/$servicePrefix/groups/$groupId/moderate/",
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.post(
        "/$servicePrefix/groups/$groupId/join/",
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.post(
        "/$servicePrefix/groups/$groupId/leave/",
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.delete(
        "/$servicePrefix/groups/$groupId/delete/",
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.get(
        "/$servicePrefix/groups/$communityId/$userType",
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.post(
        "/$servicePrefix/groups/$communityId/rules/",
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

  Future<Either<Failure, PaginatedCommunityResponse>> getPostableCommunities({
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.get(
        "/$servicePrefix/community/postable",
        queryParameters: {"page": page, "page_size": pageSize},
      );
      if (response.statusCode == 200) {
        return right(PaginatedCommunityResponse.fromJson(response.data));
      }
      throw "Programming error";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "Something went wrong while attempting to fetch your communities",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PaginatedCommunityResponse>> searchForCommunity(
    String searchTerm, {
    int page = 1,
    int pageSize = 100,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.get(
        "/$servicePrefix/community/search/",
        queryParameters: {"q": searchTerm, "page": page, "page_size": pageSize},
      );
      if (response.statusCode == 200) {
        return right(PaginatedCommunityResponse.fromJson(response.data));
      }
      throw "Programming error";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Something went wrong while searching for community.",
          error: e,
        ),
      );
    }
  }
}
