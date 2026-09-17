import 'package:database/app_database_v2.dart';
import 'package:database/di/database_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const pathProviderChannel = MethodChannel('plugins.flutter.io/path_provider');

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathProviderChannel, (call) async {
          if (call.method == 'getApplicationSupportDirectory' ||
              call.method == 'getTemporaryDirectory') {
            return '/tmp';
          }
          return null;
        });
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(pathProviderChannel, null);
  });

  test('registers AppDatabaseV2 without requiring a QueryExecutor', () async {
    final getIt = GetIt.asNewInstance();
    configureLocalDatabaseDependencies(getIt);

    final database = getIt<AppDatabaseV2>();

    expect(database, isA<AppDatabaseV2>());
    await database.close();
    await getIt.reset();
  });
}
