import 'package:flutter_test/flutter_test.dart';
import 'package:institutions/institutions.dart';

void main() {
  group('MonetaryAmount.observe', () {
    test('never defaults an unknown currency to KES', () {
      final amount = MonetaryAmount.observe(rawAmount: '1,234.50');
      expect(amount.currencyCode, isNull);
      expect(amount.hasKnownCurrency, isFalse);
      expect(amount.normalizedAmount, '1234.50');
    });

    test('retains a confirmed non-KES currency', () {
      final amount = MonetaryAmount.observe(
        currencyText: 'UGX',
        rawAmount: '250,000',
      );
      expect(amount.currencyCode, 'UGX');
      expect(amount.normalizedAmount, '250000.00');
    });

    test('rejects a symbol instead of guessing a currency code', () {
      final amount = MonetaryAmount.observe(
        currencyText: r'$',
        rawAmount: '100',
      );
      expect(amount.currencyCode, isNull);
    });

    test('parses comma-decimal localized amounts (1.234,50)', () {
      final amount = MonetaryAmount.observe(rawAmount: '1.234,50');
      expect(amount.normalizedAmount, '1234.50');
    });

    test('treats a 3-digit trailing group as thousands, not decimals', () {
      final amount = MonetaryAmount.observe(rawAmount: '12,345');
      expect(amount.normalizedAmount, '12345.00');
    });

    test('never defaults an unparsable amount to zero', () {
      final amount = MonetaryAmount.observe(rawAmount: 'N/A');
      expect(amount.normalizedAmount, isNull);
      expect(amount.validationOutcome, FieldValidationOutcome.rejected);
      expect(amount.isValid, isFalse);
    });

    test('handles a parenthesized negative amount', () {
      final amount = MonetaryAmount.observe(rawAmount: '(500.00)');
      expect(amount.normalizedAmount, '-500.00');
    });
  });

  FeeLineItemEntity line({
    required String sourceId,
    required FeeLineKind kind,
    required String description,
    String? currency,
    required String rawAmount,
  }) => FeeLineItemEntity(
    sourceId: sourceId,
    kind: kind,
    description: description,
    amount: MonetaryAmount.observe(currencyText: currency, rawAmount: rawAmount),
    evidence: FieldEvidence(
      sourcePage: '/fees',
      observedAt: DateTime.utc(2026, 10, 1),
      sourceAccount: 'student-1',
      originalValue: rawAmount,
      normalizedValue: MonetaryAmount.normalizeLocalizedAmount(rawAmount),
      validationOutcome: FieldValidationOutcome.valid,
    ),
  );

  test('a statement with debit/credit/balance lines in a non-KES currency is valid', () {
    final statement = FeeStatementEntity(
      sourceId: 'stmt-1',
      accountId: 'student-1',
      institutionId: 10,
      term: '2026/1',
      lineItems: [
        line(
          sourceId: 'l1',
          kind: FeeLineKind.debit,
          description: 'Tuition fee',
          currency: 'UGX',
          rawAmount: '1,500,000',
        ),
        line(
          sourceId: 'l2',
          kind: FeeLineKind.credit,
          description: 'Bank payment',
          currency: 'UGX',
          rawAmount: '500,000',
        ),
        line(
          sourceId: 'l3',
          kind: FeeLineKind.balanceDue,
          description: 'Balance due',
          currency: 'UGX',
          rawAmount: '1,000,000',
        ),
      ],
      observedAt: DateTime.utc(2026, 10, 1),
    );
    expect(statement.isValid, isTrue);
    expect(
      statement.lineItems.every((item) => item.amount.currencyCode == 'UGX'),
      isTrue,
    );
  });

  test('duplicate line source ids make a statement invalid', () {
    final duplicate = line(
      sourceId: 'l1',
      kind: FeeLineKind.debit,
      description: 'Tuition fee',
      rawAmount: '100',
    );
    final statement = FeeStatementEntity(
      sourceId: 'stmt-1',
      accountId: 'student-1',
      institutionId: 10,
      lineItems: [duplicate, duplicate],
      observedAt: DateTime.utc(2026, 10, 1),
    );
    expect(statement.isValid, isFalse);
  });

  test('merging a partial capture keeps lines absent from it', () {
    final original = FeeStatementEntity(
      sourceId: 'stmt-1',
      accountId: 'student-1',
      institutionId: 10,
      lineItems: [
        line(
          sourceId: 'l1',
          kind: FeeLineKind.debit,
          description: 'Tuition fee',
          rawAmount: '100',
        ),
        line(
          sourceId: 'l2',
          kind: FeeLineKind.credit,
          description: 'Payment',
          rawAmount: '40',
        ),
      ],
      observedAt: DateTime.utc(2026, 10, 1),
    );
    final partial = FeeStatementEntity(
      sourceId: 'stmt-1',
      accountId: 'student-1',
      institutionId: 10,
      lineItems: [
        line(
          sourceId: 'l1',
          kind: FeeLineKind.debit,
          description: 'Tuition fee',
          rawAmount: '150',
        ),
      ],
      observedAt: DateTime.utc(2026, 10, 2),
    );
    final merged = original.mergedWith(partial);
    expect(merged.lineItems, hasLength(2));
    expect(
      merged.lineItems.firstWhere((item) => item.sourceId == 'l1').amount.normalizedAmount,
      '150.00',
    );
    expect(
      merged.lineItems.any((item) => item.sourceId == 'l2'),
      isTrue,
    );
  });

  test('round-trips through JSON', () {
    final statement = FeeStatementEntity(
      sourceId: 'stmt-1',
      accountId: 'student-1',
      institutionId: 10,
      lineItems: [
        line(
          sourceId: 'l1',
          kind: FeeLineKind.runningBalance,
          description: 'Running balance',
          currency: 'TZS',
          rawAmount: '2,000.75',
        ),
      ],
      observedAt: DateTime.utc(2026, 10, 1),
    );
    final decoded = FeeStatementEntity.fromJson(statement.toJson());
    expect(decoded.lineItems.single.amount.currencyCode, 'TZS');
    expect(decoded.lineItems.single.amount.normalizedAmount, '2000.75');
  });
}
