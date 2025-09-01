import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/features/communities/data/models/community_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CommunityRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final String baseUrl = "https://qachirp.opencrafts.io";

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
        "$baseUrl/create/",
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
}
