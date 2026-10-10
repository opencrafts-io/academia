import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  test('Gemini 3 requests omit unsupported sampling parameters', () async {
    final firebase = _CaptureConfiguration();
    final client = FirebasePortalAnalysisClient(firebaseAI: firebase);
    await expectLater(
      client.analyze(
        PortalInferenceRequest(
          accountId: 'account-a',
          budgetKey: 'budget-a',
          structuralContent: {},
          modelVersion: '',
        ),
      ),
      throwsA(isA<_ConfigurationCaptured>()),
    );
    final serialized = firebase.configuration!.toJson();
    for (final unsupported in [
      'temperature',
      'topP',
      'topK',
      'candidateCount',
    ]) {
      expect(serialized.containsKey(unsupported), isFalse, reason: unsupported);
    }
    expect(firebase.model, 'gemini-3.8-flash');
    expect(serialized['responseMimeType'], 'application/json');
    expect(serialized['maxOutputTokens'], 1000);
    expect(serialized['responseSchema'], isNotNull);
  });

  test(
    'uses the compact provider-tested schema while validating indices locally',
    () async {
      final firebase = _CaptureConfiguration();
      final client = FirebasePortalAnalysisClient(firebaseAI: firebase);
      await expectLater(
        client.analyze(
          PortalInferenceRequest(
            accountId: 'account-a',
            budgetKey: 'budget-a',
            structuralContent: {},
            modelVersion: '',
          ),
        ),
        throwsA(isA<_ConfigurationCaptured>()),
      );
      final schema = firebase.configuration!.responseSchema!.toJson();
      final table =
          ((schema['properties'] as Map)['tables'] as Map)['items'] as Map;
      final columns = (table['properties'] as Map)['columns'] as Map;
      expect(
        columns['required'],
        unorderedEquals([
          'code',
          'title',
          'day',
          'start',
          'end',
          'venue',
          'term',
        ]),
      );
      for (final field in (columns['properties'] as Map).values.cast<Map>()) {
        expect(field['nullable'], isTrue);
      }
      void verifyCompactSchema(Object? value) {
        if (value is Map) {
          for (final unsupported in [
            'minimum',
            'maximum',
            'maxItems',
            'format',
          ]) {
            expect(
              value.containsKey(unsupported),
              isFalse,
              reason: unsupported,
            );
          }
          for (final child in value.values) {
            verifyCompactSchema(child);
          }
        } else if (value is List) {
          for (final child in value) {
            verifyCompactSchema(child);
          }
        }
      }

      verifyCompactSchema(schema);
      expect(
        schema['required'],
        unorderedEquals(['pageType', 'tables', 'hint']),
      );
      // Required fields may be null; bounds still apply to returned indices.
      expect(PortalColumnMap.fromJson({'code': null}).code, isNull);
      expect(
        () => PortalColumnMap.fromJson({'code': 64}),
        throwsFormatException,
      );
    },
  );

  group('analyzeMedia (document/image fallback)', () {
    test(
      'builds a value-returning schema distinct from the DOM column plan',
      () async {
        final firebase = _CaptureConfiguration();
        final client = FirebasePortalAnalysisClient(firebaseAI: firebase);
        final selection = PortalMediaSelection.validated(
          bytes: Uint8List.fromList([1, 2, 3, 4]),
          mimeType: 'image/jpeg',
          kind: PortalMediaKind.image,
        );
        await expectLater(
          client.analyzeMedia(
            PortalMediaAnalysisRequest(selection: selection, modelVersion: ''),
          ),
          throwsA(isA<_ConfigurationCaptured>()),
        );
        final schema = firebase.configuration!.responseSchema!.toJson();
        expect(
          schema['required'],
          unorderedEquals(['pageType', 'courses', 'meetings']),
        );
        final courseItem =
            ((schema['properties'] as Map)['courses'] as Map)['items'] as Map;
        expect(
          courseItem['required'],
          unorderedEquals(['code', 'title', 'term', 'section', 'lecturer']),
        );
        final meetingItem =
            ((schema['properties'] as Map)['meetings'] as Map)['items'] as Map;
        expect(
          meetingItem['required'],
          unorderedEquals(['code', 'day', 'start', 'end', 'venue', 'term']),
        );
        // Values are strings here, not the DOM path's integer column indices:
        // there is no local table to index into for an image/document.
        expect((courseItem['properties'] as Map)['code']['type'], 'STRING');
        for (final optional in ['term', 'section', 'lecturer']) {
          expect(
            (courseItem['properties'] as Map)[optional]['nullable'],
            isTrue,
          );
        }
        expect(
          firebase.configuration!.toJson()['responseMimeType'],
          'application/json',
        );
      },
    );

    test('reuses the same model instance plumbing as the DOM path', () async {
      final firebase = _CaptureConfiguration();
      final client = FirebasePortalAnalysisClient(
        firebaseAI: firebase,
        modelName: 'gemini-3.5-flash-lite',
      );
      final selection = PortalMediaSelection.validated(
        bytes: Uint8List.fromList(List.filled(10, 9)),
        mimeType: 'application/pdf',
        kind: PortalMediaKind.document,
      );
      await expectLater(
        client.analyzeMedia(
          PortalMediaAnalysisRequest(selection: selection, modelVersion: ''),
        ),
        throwsA(isA<_ConfigurationCaptured>()),
      );
      expect(firebase.model, 'gemini-3.5-flash-lite');
      expect(firebase.configuration!.toJson()['maxOutputTokens'], 1000);
    });
  });
}

// Capture the actual SDK configuration without making a billable cloud request.
class _CaptureConfiguration implements FirebaseAI {
  GenerationConfig? configuration;
  String? model;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #generativeModel) {
      configuration =
          invocation.namedArguments[#generationConfig] as GenerationConfig;
      model = invocation.namedArguments[#model] as String;
      throw _ConfigurationCaptured();
    }
    return super.noSuchMethod(invocation);
  }
}

class _ConfigurationCaptured implements Exception {}
