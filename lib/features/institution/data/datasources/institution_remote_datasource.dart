import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class InstitutionRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final String servicePrefix;

  InstitutionRemoteDatasource({
    required this.dioClient,
    this.servicePrefix = "qa-verisafe",
  });

  Future<List<InstitutionData>> _parseInstitutions(List<dynamic> raw) async {
    return raw.map((e) => InstitutionData.fromJson(e)).toList();
  }

  Future<Either<Failure, List<InstitutionData>>> searchForInstitutionByName(
    String name, {
    int page = 0,
    pageSize = 100,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/institutions/search",
        queryParameters: {"q": name, "limit": pageSize, "offset": page},
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawInstitutions = response.data;
        final institutions = await compute(_parseInstitutions, rawInstitutions);
        return right(institutions);
      }

      throw ("Wrong status code returned from server expected 200 got ${response.statusCode}");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        NetworkFailure(
          message:
              "We could't search for your institution at the moment."
              "Please try again later",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, bool>> addAccountToInstitution(
    String accountID,
    int institutionID,
  ) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/institutions/account",
        data: {"account_id": accountID, "institution_id": institutionID},
      );

      if (response.statusCode == 201) {
        return right(true);
      }
      throw ("Wrong status code returned from server expected 201 got ${response.statusCode}");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        NetworkFailure(
          message:
              "We could't add account to this institution at the moment."
              "Please try again later",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<InstitutionData>>> getAccountInstitutions(
    String accountID, {
    int page = 0,
    pageSize = 100,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePrefix/institutions/for-account",
        queryParameters: {
          "account_id": accountID,
          "limit": pageSize,
          "offset": page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawInstitutions = response.data;
        final institutions = await compute(_parseInstitutions, rawInstitutions);
        return right(institutions);
      }

      throw ("Wrong status code returned from server expected 200 got ${response.statusCode}");
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        NetworkFailure(
          message:
              "We could't fetch institutions for account at the moment."
              "Please try again later",
          error: e,
        ),
      );
    }
  }
}
