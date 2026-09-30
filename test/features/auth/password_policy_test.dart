import 'package:academia/features/auth/domain/password_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PasswordPolicy.validate', () {
    test('requires at least 12 Unicode code points', () {
      expect(
        PasswordPolicy.validate('a' * 11),
        'Password must be 12 to 128 characters long.',
      );
    });

    test('counts Unicode code points rather than UTF-16 code units', () {
      expect(PasswordPolicy.validate('😀' * 12), isNull);
    });

    test('accepts the 128 code point maximum', () {
      expect(PasswordPolicy.validate('a' * 128), isNull);
    });

    test(
      'rejects passwords longer than 128 code points without truncating',
      () {
        expect(
          PasswordPolicy.validate('a' * 129),
          'Password must be 12 to 128 characters long.',
        );
      },
    );
  });
}
