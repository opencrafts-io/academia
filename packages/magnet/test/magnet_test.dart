import 'package:flutter_test/flutter_test.dart';

import 'package:magnet/magnet.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Magnet Engine should initialize with development config', () async {
    final config = MagnetConfig(schemaServerUrl: "http://api.opencrafts.io/");
    final magnet = await Magnet.init(config: config);
    expect(magnet.initialized, true);
    expect(magnet.config.debugMode, true);
  });
}
