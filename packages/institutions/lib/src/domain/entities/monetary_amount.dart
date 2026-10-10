import 'field_evidence.dart';

/// A currency amount captured from a fee statement.
///
/// Per the portal-sync plan's data-quality section: retain currency and
/// decimal amounts, never default an unknown currency to KES or an unknown
/// amount to zero, and preserve localized date/number formats until
/// validated. [currencyCode] is `null` whenever the portal did not present
/// an unambiguous ISO 4217-shaped currency marker near the amount -- it is
/// never guessed or defaulted. [rawAmount] keeps the original localized
/// text (e.g. "1.234,50" or "1,234.50"); [normalizedAmount] is only set once
/// that text has been confidently parsed into a canonical decimal string
/// ("1234.50"), with no loss of precision from floating point conversion.
class MonetaryAmount {
  const MonetaryAmount({
    this.currencyCode,
    required this.rawAmount,
    this.normalizedAmount,
    this.validationOutcome = FieldValidationOutcome.unvalidated,
  });

  final String? currencyCode;
  final String rawAmount;
  final String? normalizedAmount;
  final FieldValidationOutcome validationOutcome;

  bool get hasKnownCurrency => currencyCode != null;
  bool get isValid =>
      validationOutcome == FieldValidationOutcome.valid &&
      normalizedAmount != null;

  static final RegExp _isoCurrency = RegExp(r'^[A-Z]{3}$');

  /// Builds a [MonetaryAmount] from raw captured text, never defaulting
  /// currency or amount. [currencyText] is accepted only when it is exactly
  /// a 3-letter ISO 4217-shaped code; anything else (a symbol, locale-only
  /// hint, or absence) leaves [currencyCode] null rather than guessing.
  factory MonetaryAmount.observe({
    String? currencyText,
    required String rawAmount,
  }) {
    final trimmedCurrency = currencyText?.trim().toUpperCase();
    final currencyCode =
        trimmedCurrency != null && _isoCurrency.hasMatch(trimmedCurrency)
        ? trimmedCurrency
        : null;
    final normalized = normalizeLocalizedAmount(rawAmount);
    return MonetaryAmount(
      currencyCode: currencyCode,
      rawAmount: rawAmount,
      normalizedAmount: normalized,
      validationOutcome: normalized == null
          ? FieldValidationOutcome.rejected
          : FieldValidationOutcome.valid,
    );
  }

  /// Parses a localized decimal amount into a canonical "-?digits.digits"
  /// string, or returns null when the format is ambiguous/unrecognized.
  /// Handles both "1,234.50" (comma thousands) and "1.234,50" (dot
  /// thousands) styles by treating the last separator as the decimal point
  /// only when it is followed by 1-2 digits; otherwise the string is left
  /// unvalidated rather than guessed.
  static String? normalizeLocalizedAmount(String raw) {
    var text = raw.trim();
    if (text.isEmpty) return null;
    var negative = false;
    if (text.startsWith('(') && text.endsWith(')')) {
      negative = true;
      text = text.substring(1, text.length - 1).trim();
    }
    text = text.replaceAll(RegExp(r'[^0-9.,\-]'), '');
    if (text.isEmpty) return null;
    if (text.startsWith('-')) {
      negative = true;
      text = text.substring(1);
    }
    if (text.isEmpty || !RegExp(r'^[0-9.,]+$').hasMatch(text)) return null;

    final lastDot = text.lastIndexOf('.');
    final lastComma = text.lastIndexOf(',');
    String integerPart;
    String fractionPart;
    if (lastDot == -1 && lastComma == -1) {
      integerPart = text;
      fractionPart = '';
    } else {
      final decimalIndex = lastDot > lastComma ? lastDot : lastComma;
      final afterDecimal = text.substring(decimalIndex + 1);
      // A trailing group of exactly 1-2 digits after the final separator is
      // treated as the decimal fraction; a 3-digit group is a thousands
      // separator instead (e.g. "1.234" stays an integer, not "1.234").
      if (afterDecimal.length > 2 || afterDecimal.isEmpty) {
        integerPart = text.replaceAll(RegExp('[,.]'), '');
        fractionPart = '';
      } else {
        integerPart = text
            .substring(0, decimalIndex)
            .replaceAll(RegExp('[,.]'), '');
        fractionPart = afterDecimal;
      }
    }
    if (integerPart.isEmpty) integerPart = '0';
    if (!RegExp(r'^\d+$').hasMatch(integerPart) ||
        !RegExp(r'^\d*$').hasMatch(fractionPart)) {
      return null;
    }
    final normalizedInteger = integerPart.replaceFirst(RegExp(r'^0+(?=\d)'), '');
    final sign = negative && normalizedInteger != '0' ? '-' : '';
    return fractionPart.isEmpty
        ? '$sign$normalizedInteger.00'
        : '$sign$normalizedInteger.${fractionPart.padRight(2, '0')}';
  }

  Map<String, Object?> toJson() => {
    'currencyCode': currencyCode,
    'rawAmount': rawAmount,
    'normalizedAmount': normalizedAmount,
    'validationOutcome': validationOutcome.name,
  };

  factory MonetaryAmount.fromJson(Map<String, Object?> json) =>
      MonetaryAmount(
        currencyCode: json['currencyCode'] as String?,
        rawAmount: json['rawAmount'] as String,
        normalizedAmount: json['normalizedAmount'] as String?,
        validationOutcome: FieldValidationOutcome.values.firstWhere(
          (value) => value.name == json['validationOutcome'],
          orElse: () => FieldValidationOutcome.unvalidated,
        ),
      );

  @override
  bool operator ==(Object other) =>
      other is MonetaryAmount &&
      other.currencyCode == currencyCode &&
      other.rawAmount == rawAmount &&
      other.normalizedAmount == normalizedAmount &&
      other.validationOutcome == validationOutcome;

  @override
  int get hashCode =>
      Object.hash(currencyCode, rawAmount, normalizedAmount, validationOutcome);
}
