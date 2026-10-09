import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/sensitive_request_inspector.dart';
import 'package:academia/core/network/verisafe_auth_interceptor.dart';
import 'package:academia/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:core/config/flavor.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('request inspector runs before auth marks requests sensitive', () {
    final client = DioClient(
      FlavorConfig(
        flavor: Flavor.staging,
        appName: 'test',
        apiBaseUrl: 'https://example.test',
      ),
      authLocalDatasource: AuthLocalDatasource(),
      requestInspector: DioRequestInspector(isInspectorEnabled: true),
    );

    final interceptors = client.dio.interceptors;
    final inspectorIndex = interceptors.indexWhere(
      (interceptor) => interceptor is SensitiveRequestInspector,
    );
    final authIndex = interceptors.indexWhere(
      (interceptor) => interceptor is VerisafeAuthInterceptor,
    );

    expect(inspectorIndex, greaterThanOrEqualTo(0));
    expect(authIndex, greaterThanOrEqualTo(0));
    expect(inspectorIndex, lessThan(authIndex));
  });
}
