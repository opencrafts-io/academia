import 'package:flutter_test/flutter_test.dart';
import 'package:academia/features/sherehe/data/models/purchase_ticket_result_model.dart';

void main() {
  group('PurchaseTicketResult', () {
    group('FreeTicketSuccess', () {
      test('creates with required message', () {
        const result = FreeTicketSuccess(message: 'Ticket claimed successfully');
        expect(result.message, 'Ticket claimed successfully');
      });

      test('is a subtype of PurchaseTicketResult', () {
        const result = FreeTicketSuccess(message: 'Free ticket!');
        expect(result, isA<PurchaseTicketResult>());
      });

      test('stores message correctly', () {
        const message = 'Your free ticket has been issued';
        const result = FreeTicketSuccess(message: message);
        expect(result.message, message);
      });

      test('does not have transactionId', () {
        const result = FreeTicketSuccess(message: 'Got it!');
        // FreeTicketSuccess should not have transactionId
        expect(result is PaidTicketInitiated, isFalse);
      });
    });

    group('PaidTicketInitiated', () {
      test('creates with required message and transactionId', () {
        const result = PaidTicketInitiated(
          message: 'Payment initiated',
          transactionId: 'TXN-ABC-123',
        );
        expect(result.message, 'Payment initiated');
        expect(result.transactionId, 'TXN-ABC-123');
      });

      test('is a subtype of PurchaseTicketResult', () {
        const result = PaidTicketInitiated(
          message: 'STK push sent',
          transactionId: 'TXN-456',
        );
        expect(result, isA<PurchaseTicketResult>());
      });

      test('stores transactionId correctly', () {
        const transactionId = 'MPESA-TXN-789-XYZ';
        const result = PaidTicketInitiated(
          message: 'Check your phone',
          transactionId: transactionId,
        );
        expect(result.transactionId, transactionId);
      });

      test('stores long transactionId correctly', () {
        const longTxnId = 'VERY-LONG-TRANSACTION-ID-1234567890-ABCDEFGHIJ';
        const result = PaidTicketInitiated(
          message: 'Processing',
          transactionId: longTxnId,
        );
        expect(result.transactionId, longTxnId);
      });
    });

    group('type discrimination', () {
      test('FreeTicketSuccess and PaidTicketInitiated are different types', () {
        const freeResult = FreeTicketSuccess(message: 'Free');
        const paidResult = PaidTicketInitiated(
          message: 'Paid',
          transactionId: 'TXN-1',
        );

        expect(freeResult, isA<FreeTicketSuccess>());
        expect(freeResult, isNot(isA<PaidTicketInitiated>()));
        expect(paidResult, isA<PaidTicketInitiated>());
        expect(paidResult, isNot(isA<FreeTicketSuccess>()));
      });

      test('can cast PurchaseTicketResult to FreeTicketSuccess', () {
        final PurchaseTicketResult result =
            FreeTicketSuccess(message: 'Free ticket!');
        expect(result is FreeTicketSuccess, isTrue);
        expect((result as FreeTicketSuccess).message, 'Free ticket!');
      });

      test('can cast PurchaseTicketResult to PaidTicketInitiated', () {
        final PurchaseTicketResult result = PaidTicketInitiated(
          message: 'Payment pending',
          transactionId: 'TX-99',
        );
        expect(result is PaidTicketInitiated, isTrue);
        final paid = result as PaidTicketInitiated;
        expect(paid.message, 'Payment pending');
        expect(paid.transactionId, 'TX-99');
      });

      test('switch-style discrimination works for free event', () {
        final PurchaseTicketResult result =
            FreeTicketSuccess(message: 'Enjoy the event!');
        String? txnId;
        if (result is PaidTicketInitiated) {
          txnId = result.transactionId;
        }
        expect(txnId, isNull);
      });

      test('switch-style discrimination works for paid event', () {
        final PurchaseTicketResult result = PaidTicketInitiated(
          message: 'Check Mpesa',
          transactionId: 'MPESA-001',
        );
        String? txnId;
        if (result is PaidTicketInitiated) {
          txnId = result.transactionId;
        }
        expect(txnId, 'MPESA-001');
      });
    });
  });
}