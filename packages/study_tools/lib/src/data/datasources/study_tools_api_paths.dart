import 'package:core/config/flavor.dart';

class StudyToolsApiPaths {
  StudyToolsApiPaths(this.flavorConfig);

  final FlavorConfig flavorConfig;

  String get collection => '${_prefix}api/notes/';
  String detail(int noteId) => '$collection$noteId/';
  String generate(int noteId) => '${detail(noteId)}generate/';
  String job(int jobId) => '${collection}jobs/$jobId/';
  String questions(int noteId) => '${detail(noteId)}questions/';

  String get _prefix =>
      flavorConfig.isProduction ? '/professor/' : '/qa-professor/';
}
