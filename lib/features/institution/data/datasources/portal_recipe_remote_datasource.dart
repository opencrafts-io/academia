import 'package:academia/core/network/dio_client.dart';
import 'package:core/config/flavor.dart';
import 'package:dio/dio.dart';
import 'package:magnet/magnet.dart';

/// The mobile client only receives recipes that have been published for the
/// institution and the exact portal origin currently open in the browser.
class PortalRecipeRemoteDatasource {
  PortalRecipeRemoteDatasource({
    required DioClient dioClient,
    required FlavorConfig flavor,
  }) : _dio = dioClient.dio,
       _servicePrefix = flavor.isProduction
           ? 'professor'
           : flavor.isStaging
           ? 'qa-professor'
           : 'dev-professor';

  final Dio _dio;
  final String _servicePrefix;

  Future<PublishedPortalRecipe?> fetchPublishedRecipe({
    required int institutionId,
    required Uri origin,
  }) async {
    _requireSecureOrigin(origin);
    final response = await _dio.get<dynamic>(
      '/$_servicePrefix/api/magnet/recipes/for/$institutionId',
      queryParameters: {'origin': origin.origin},
    );
    if (response.statusCode == 404) return null;
    _requireSuccess(response, 200);

    final json = Map<String, dynamic>.from(response.data as Map);
    final recipeOrigin = Uri.parse(json['origin'] as String);
    _requireSecureOrigin(recipeOrigin);
    if (recipeOrigin.origin != origin.origin) {
      throw const FormatException('Recipe origin does not match this portal.');
    }
    if (json['requires_interaction'] != true) {
      throw const FormatException('Visible portal recipe required.');
    }
    final recipeId = json['recipe_id']?.toString();
    final version = json['version']?.toString();
    if (recipeId == null || recipeId.isEmpty || version == null) {
      throw const FormatException('Recipe identity or version is missing.');
    }
    final command = ScrappingCommand.fromJson({
      'command_id': json['command_id'] ?? recipeId,
      'url': json['url'] ?? origin.toString(),
      'requires_interaction': true,
      'instructions': json['instructions'],
    });
    final commandUrl = Uri.parse(command.url);
    _requireSecureOrigin(commandUrl);
    if (commandUrl.origin != origin.origin) {
      throw const FormatException('Recipe URL does not match this portal.');
    }
    return PublishedPortalRecipe(
      recipeId: recipeId,
      version: version,
      origin: origin.origin,
      command: command,
      columnMappings: _readColumnMappings(json['column_mappings']),
    );
  }

  static Map<String, Map<String, String>> _readColumnMappings(dynamic value) {
    if (value == null) return const {};
    if (value is! Map) {
      throw const FormatException('Recipe column mappings are invalid.');
    }
    return value.map((key, columns) {
      if (key is! String || columns is! Map) {
        throw const FormatException('Recipe column mappings are invalid.');
      }
      return MapEntry(
        key,
        columns.map((source, target) {
          if (source is! String || target is! String) {
            throw const FormatException('Recipe column mapping is invalid.');
          }
          return MapEntry(source, target);
        }),
      );
    });
  }

  Future<String> submitTeachingCapture({
    required int institutionId,
    required Uri origin,
    required String goal,
    required List<Map<String, dynamic>> trace,
  }) async {
    _requireSecureOrigin(origin);
    final response = await _dio.post<dynamic>(
      '/$_servicePrefix/api/magnet/teaching-captures',
      data: {
        'institution_id': institutionId,
        'origin': origin.origin,
        'goal': goal,
        'trace': trace,
      },
    );
    _requireSuccess(response, 201);
    final json = Map<String, dynamic>.from(response.data as Map);
    final captureId = json['id']?.toString() ?? json['capture_id']?.toString();
    if (captureId == null || captureId.isEmpty) {
      throw const FormatException('Capture identity is missing.');
    }
    return captureId;
  }

  Future<void> requestDraft(String captureId) async {
    final response = await _dio.post<dynamic>(
      '/$_servicePrefix/api/magnet/teaching-captures/$captureId/generate',
    );
    if (response.statusCode != 200 && response.statusCode != 202) {
      throw StateError('Recipe draft request failed (${response.statusCode}).');
    }
  }

  static void _requireSecureOrigin(Uri origin) {
    if (origin.scheme != 'https' ||
        origin.host.isEmpty ||
        origin.userInfo.isNotEmpty ||
        origin.hasQuery ||
        origin.hasFragment ||
        (origin.path.isNotEmpty && origin.path != '/')) {
      throw const FormatException('A secure portal origin is required.');
    }
  }

  static void _requireSuccess(Response<dynamic> response, int status) {
    if (response.statusCode != status) {
      throw StateError('Portal request failed (${response.statusCode}).');
    }
  }
}

class PublishedPortalRecipe {
  const PublishedPortalRecipe({
    required this.recipeId,
    required this.version,
    required this.origin,
    required this.command,
    required this.columnMappings,
  });

  final String recipeId;
  final String version;
  final String origin;
  final ScrappingCommand command;
  final Map<String, Map<String, String>> columnMappings;
}
