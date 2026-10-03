/// Password constraints enforced by the Verisafe password endpoints.
class PasswordPolicy {
  const PasswordPolicy._();

  static const int minimumCodePoints = 12;
  static const int maximumCodePoints = 128;
  static const String lengthError =
      'Password must be 12 to 128 characters long.';

  /// Returns an inline validation message, or `null` when [password] is valid.
  ///
  /// Dart strings use UTF-16 internally, while the API counts Unicode code
  /// points. [String.runes] keeps supplementary characters such as emoji as a
  /// single character for this rule.
  static String? validate(String password) {
    final length = password.runes.length;
    if (length < minimumCodePoints || length > maximumCodePoints) {
      return lengthError;
    }
    return null;
  }
}
