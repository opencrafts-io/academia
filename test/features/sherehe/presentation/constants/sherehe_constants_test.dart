import 'package:flutter_test/flutter_test.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';

void main() {
  group('ScopeTypes', () {
    group('toBackend', () {
      test('public scope maps to "public"', () {
        expect(ScopeTypes.public.toBackend, 'public');
      });

      test('institution scope maps to "institution"', () {
        expect(ScopeTypes.institution.toBackend, 'institution');
      });

      test('private scope maps to "private"', () {
        expect(ScopeTypes.private.toBackend, 'private');
      });
    });

    group('fromBackend', () {
      test('parses "public" to ScopeTypes.public', () {
        expect(ScopeTypesX.fromBackend('public'), ScopeTypes.public);
      });

      test('parses "institution" to ScopeTypes.institution', () {
        expect(ScopeTypesX.fromBackend('institution'), ScopeTypes.institution);
      });

      test('parses "private" to ScopeTypes.private', () {
        expect(ScopeTypesX.fromBackend('private'), ScopeTypes.private);
      });

      test('throws Exception for unknown value', () {
        expect(
          () => ScopeTypesX.fromBackend('unknown'),
          throwsA(isA<Exception>()),
        );
      });

      test('throws Exception for empty string', () {
        expect(
          () => ScopeTypesX.fromBackend(''),
          throwsA(isA<Exception>()),
        );
      });

      test('throws Exception for capitalized value', () {
        // Backend values are lowercase; "Public" should fail
        expect(
          () => ScopeTypesX.fromBackend('Public'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('label', () {
      test('public label is "Public"', () {
        expect(ScopeTypes.public.label, 'Public');
      });

      test('institution label is "Institution"', () {
        expect(ScopeTypes.institution.label, 'Institution');
      });

      test('private label is "Private"', () {
        expect(ScopeTypes.private.label, 'Private');
      });
    });

    group('toBackend/fromBackend roundtrip', () {
      test('public roundtrip', () {
        final original = ScopeTypes.public;
        final backend = original.toBackend;
        final restored = ScopeTypesX.fromBackend(backend);
        expect(restored, original);
      });

      test('institution roundtrip', () {
        final original = ScopeTypes.institution;
        final backend = original.toBackend;
        final restored = ScopeTypesX.fromBackend(backend);
        expect(restored, original);
      });

      test('private roundtrip', () {
        final original = ScopeTypes.private;
        final backend = original.toBackend;
        final restored = ScopeTypesX.fromBackend(backend);
        expect(restored, original);
      });
    });

    group('enum values', () {
      test('ScopeTypes has exactly 3 values', () {
        expect(ScopeTypes.values.length, 3);
      });

      test('ScopeTypes values are public, institution, private', () {
        expect(ScopeTypes.values, containsAll([
          ScopeTypes.public,
          ScopeTypes.institution,
          ScopeTypes.private,
        ]));
      });
    });
  });

  group('TicketGroupTypes', () {
    group('toBackend', () {
      test('individual maps to 1', () {
        expect(TicketGroupTypes.individual.toBackend, 1);
      });

      test('groupOfTwo maps to 2', () {
        expect(TicketGroupTypes.groupOfTwo.toBackend, 2);
      });

      test('groupOfFive maps to 5', () {
        expect(TicketGroupTypes.groupOfFive.toBackend, 5);
      });
    });

    group('fromBackend', () {
      test('parses "INDIVIDUAL" to TicketGroupTypes.individual', () {
        expect(
          TicketGroupTypesX.fromBackend('INDIVIDUAL'),
          TicketGroupTypes.individual,
        );
      });

      test('parses "GROUP_OF_TWO" to TicketGroupTypes.groupOfTwo', () {
        expect(
          TicketGroupTypesX.fromBackend('GROUP_OF_TWO'),
          TicketGroupTypes.groupOfTwo,
        );
      });

      test('parses "GROUP_OF_FIVE" to TicketGroupTypes.groupOfFive', () {
        expect(
          TicketGroupTypesX.fromBackend('GROUP_OF_FIVE'),
          TicketGroupTypes.groupOfFive,
        );
      });

      test('throws Exception for unknown value', () {
        expect(
          () => TicketGroupTypesX.fromBackend('UNKNOWN'),
          throwsA(isA<Exception>()),
        );
      });

      test('throws Exception for lowercase value', () {
        expect(
          () => TicketGroupTypesX.fromBackend('individual'),
          throwsA(isA<Exception>()),
        );
      });

      test('throws Exception for empty string', () {
        expect(
          () => TicketGroupTypesX.fromBackend(''),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('label', () {
      test('individual label is "Individual"', () {
        expect(TicketGroupTypes.individual.label, 'Individual');
      });

      test('groupOfTwo label is "Group of 2"', () {
        expect(TicketGroupTypes.groupOfTwo.label, 'Group of 2');
      });

      test('groupOfFive label is "Group of 5"', () {
        expect(TicketGroupTypes.groupOfFive.label, 'Group of 5');
      });
    });

    group('enum values', () {
      test('TicketGroupTypes has exactly 3 values', () {
        expect(TicketGroupTypes.values.length, 3);
      });

      test('TicketGroupTypes values include individual, groupOfTwo, groupOfFive', () {
        expect(TicketGroupTypes.values, containsAll([
          TicketGroupTypes.individual,
          TicketGroupTypes.groupOfTwo,
          TicketGroupTypes.groupOfFive,
        ]));
      });
    });
  });

  group('AttendeeStatusMapper', () {
    test('VALID maps to AttendeeStatus.valid', () {
      expect('VALID'.toAttendeeStatus(), AttendeeStatus.valid);
    });

    test('valid (lowercase) maps to AttendeeStatus.valid', () {
      expect('valid'.toAttendeeStatus(), AttendeeStatus.valid);
    });

    test('ALREADY_SCANNED maps to AttendeeStatus.alreadyScanned', () {
      expect('ALREADY_SCANNED'.toAttendeeStatus(), AttendeeStatus.alreadyScanned);
    });

    test('WRONG_EVENT maps to AttendeeStatus.wrongEvent', () {
      expect('WRONG_EVENT'.toAttendeeStatus(), AttendeeStatus.wrongEvent);
    });

    test('INVALID maps to AttendeeStatus.invalid', () {
      expect('INVALID'.toAttendeeStatus(), AttendeeStatus.invalid);
    });

    test('unknown value defaults to AttendeeStatus.invalid', () {
      expect('RANDOM_VALUE'.toAttendeeStatus(), AttendeeStatus.invalid);
    });

    test('empty string defaults to AttendeeStatus.invalid', () {
      expect(''.toAttendeeStatus(), AttendeeStatus.invalid);
    });
  });
}
