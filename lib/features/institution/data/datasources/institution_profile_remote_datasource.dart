import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InstitutionProfileRemoteDatasource
    with DioErrorHandler, ConnectivityChecker {
  final DioClient dioClient;
  late String servicePrefix;
  final FlavorConfig flavor;

  InstitutionProfileRemoteDatasource({
    required this.dioClient,
    required this.flavor,
  }) {
    if (flavor.isProduction) {
      servicePrefix = "professor/users";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-professor/users';
    } else {
      servicePrefix = "dev-professor/users";
    }
  }

  /// Fetches a list of institution profiles with optional filtering.
  ///
  /// Query parameters:
  /// - `institution_id`: Filter by institution ID
  /// - `student_id`: Filter by student ID
  /// - `program`: Filter by program name
  ///
  /// Returns:
  /// - `Right<List<InstitutionProfile>>` on success
  /// - `Left<Failure>` on error
  Future<Either<Failure, List<InstitutionProfileData>>>
  fetchInstitutionProfiles({
    int? institutionId,
    String? studentId,
    String? program,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (institutionId != null) queryParams['institution_id'] = institutionId;
      if (studentId != null) queryParams['student_id'] = studentId;
      if (program != null) queryParams['program'] = program;

      final response = await dioClient.dio.get(
        "/$servicePrefix/profile",
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      if (response.statusCode == 200) {
        final profiles = (response.data as List)
            .map(
              (profile) => InstitutionProfileData.fromJson(
                profile as Map<String, dynamic>,
              ),
            )
            .toList();
        return right(profiles);
      }

      throw "Wrong status code returned from server expected 200 got ${response.statusCode}";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Failed to fetch institution profiles",
          error: e,
        ),
      );
    }
  }

  /// Fetches a single institution profile by ID.
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` on success
  /// - `Left<Failure>` if profile not found or server error
  Future<Either<Failure, InstitutionProfileData>> fetchInstitutionProfileById({
    required int profileId,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/profile/$profileId/",
      );

      if (response.statusCode == 200) {
        return right(InstitutionProfileData.fromJson(response.data));
      }

      throw "Wrong status code returned from server expected 200 got ${response.statusCode}";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Failed to fetch institution profile with id: $profileId",
          error: e,
        ),
      );
    }
  }

  /// Fetches the institution profile of the currently authenticated user.
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` on success
  /// - `Left<Failure>` if no profile found or server error
  Future<Either<Failure, List<InstitutionProfileData>>>
  fetchCurrentUserProfiles() async {
    try {
      final response = await dioClient.dio.get("/$servicePrefix/profile/mine");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;

        // 2. Map the list items to your Data model
        final profiles = data
            .map(
              (json) =>
                  InstitutionProfileData.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        return right(profiles);
      }

      throw "Wrong status code returned from server expected 200 got ${response.statusCode}";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Failed to fetch current user's institution profile",
          error: e,
        ),
      );
    }
  }

  /// Creates a new institution profile.
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` containing the created profile on success
  /// - `Left<Failure>` on error
  Future<Either<Failure, InstitutionProfileData>> createInstitutionProfile({
    required InstitutionProfileData profile,
  }) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePrefix/profile/create/",
        data: profile.toJson(),
      );

      if (response.statusCode == 201) {
        return right(InstitutionProfileData.fromJson(response.data));
      }

      throw "Wrong status code returned from server expected 201 got ${response.statusCode}";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Failed to create institution profile",
          error: e,
        ),
      );
    }
  }

  /// Updates an existing institution profile (full update).
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` containing the updated profile on success
  /// - `Left<Failure>` on error
  Future<Either<Failure, InstitutionProfileData>> updateInstitutionProfile({
    required int profileId,
    required InstitutionProfileData profile,
  }) async {
    try {
      final response = await dioClient.dio.put(
        "/$servicePrefix/profile/$profileId/update/",
        data: profile.toJson(),
      );

      if (response.statusCode == 200) {
        return right(InstitutionProfileData.fromJson(response.data));
      }

      throw "Wrong status code returned from server expected 200 got ${response.statusCode}";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Failed to update institution profile with id: $profileId",
          error: e,
        ),
      );
    }
  }

  /// Partially updates an existing institution profile.
  ///
  /// Returns:
  /// - `Right<InstitutionProfile>` containing the updated profile on success
  /// - `Left<Failure>` on error
  Future<Either<Failure, InstitutionProfileData>>
  partialUpdateInstitutionProfile({
    required int profileId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final response = await dioClient.dio.patch(
        "/$servicePrefix/profile/$profileId/update/",
        data: updates,
      );

      if (response.statusCode == 200) {
        return right(InstitutionProfileData.fromJson(response.data));
      }

      throw "Wrong status code returned from server expected 200 got ${response.statusCode}";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "Failed to partially update institution profile with id: $profileId",
          error: e,
        ),
      );
    }
  }

  /// Deletes an institution profile by ID.
  ///
  /// Returns:
  /// - `Right(null)` on successful deletion
  /// - `Left<Failure>` on error
  Future<Either<Failure, void>> deleteInstitutionProfile({
    required int profileId,
  }) async {
    try {
      final response = await dioClient.dio.delete(
        "/$servicePrefix/profile/$profileId/delete/",
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return right(null);
      }

      throw "Wrong status code returned from server expected 204/200 got ${response.statusCode}";
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        ServerFailure(
          message: "Failed to delete institution profile with id: $profileId",
          error: e,
        ),
      );
    }
  }
}
