import 'package:uuid/uuid.dart';

const _uuid = Uuid();
String generateUuid() => _uuid.v4();
