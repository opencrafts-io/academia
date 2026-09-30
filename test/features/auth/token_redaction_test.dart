import 'package:academia/features/auth/data/models/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TokenData debug strings never expose access or refresh tokens', () {
    final token = TokenData(
      provider: 'verisafe',
      accessToken: 'example-access-secret',
      refreshToken: 'example-refresh-secret',
      accessExpiresAt: DateTime.utc(2030),
      refreshExpiresAt: DateTime.utc(2031),
    );

    expect(token.toString(), isNot(contains('example-access-secret')));
    expect(token.toString(), isNot(contains('example-refresh-secret')));
  });
}
