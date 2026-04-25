import 'package:flutter_test/flutter_test.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/models/event_model_helper.dart';
import 'package:academia/features/sherehe/domain/entities/event.dart';

// Helper to create a minimal EventData instance for testing
EventData makeEventData({
  String id = 'event-1',
  String eventName = 'Test Event',
  String eventDescription = 'A test event',
  String eventLocation = 'Nairobi',
  String startDate = '2025-06-01T10:00:00Z',
  String endDate = '2025-06-01T20:00:00Z',
  int attendeeCount = 100,
  String organizerId = 'org-1',
  String? eventCardImage,
  String? eventPosterImage,
  String? eventBannerImage,
  String? eventUrl,
  List<dynamic>? eventGenre,
  String createdAt = '2025-01-01T00:00:00Z',
  String updatedAt = '2025-01-02T00:00:00Z',
  String? deletedAt,
  String scope = 'public',
  List<dynamic>? institutions,
  Map<String, dynamic>? paymentInfo,
}) {
  return EventData(
    id: id,
    eventName: eventName,
    eventDescription: eventDescription,
    eventLocation: eventLocation,
    startDate: startDate,
    endDate: endDate,
    attendeeCount: attendeeCount,
    organizerId: organizerId,
    eventCardImage: eventCardImage,
    eventPosterImage: eventPosterImage,
    eventBannerImage: eventBannerImage,
    eventUrl: eventUrl,
    eventGenre: eventGenre,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    scope: scope,
    institutions: institutions,
    paymentInfo: paymentInfo,
  );
}

void main() {
  group('EventModelHelper (EventData.toEntity)', () {
    test('maps required fields correctly', () {
      final model = makeEventData();
      final entity = model.toEntity();

      expect(entity.id, 'event-1');
      expect(entity.eventName, 'Test Event');
      expect(entity.eventDescription, 'A test event');
      expect(entity.eventLocation, 'Nairobi');
      expect(entity.startDate, '2025-06-01T10:00:00Z');
      expect(entity.endDate, '2025-06-01T20:00:00Z');
      expect(entity.attendeeCount, 100);
      expect(entity.organizerId, 'org-1');
      expect(entity.createdAt, '2025-01-01T00:00:00Z');
      expect(entity.updatedAt, '2025-01-02T00:00:00Z');
      expect(entity.scope, 'public');
    });

    test('maps startDate and endDate (not eventDate) to entity', () {
      final model = makeEventData(
        startDate: '2025-07-15T08:00:00Z',
        endDate: '2025-07-16T22:00:00Z',
      );
      final entity = model.toEntity();

      expect(entity.startDate, '2025-07-15T08:00:00Z');
      expect(entity.endDate, '2025-07-16T22:00:00Z');
    });

    test('maps scope field to entity', () {
      final publicModel = makeEventData(scope: 'public');
      final institutionModel = makeEventData(scope: 'institution');
      final privateModel = makeEventData(scope: 'private');

      expect(publicModel.toEntity().scope, 'public');
      expect(institutionModel.toEntity().scope, 'institution');
      expect(privateModel.toEntity().scope, 'private');
    });

    test('maps null optional fields to null in entity', () {
      final model = makeEventData();
      final entity = model.toEntity();

      expect(entity.eventCardImage, isNull);
      expect(entity.eventPosterImage, isNull);
      expect(entity.eventBannerImage, isNull);
      expect(entity.eventUrl, isNull);
      expect(entity.eventGenre, isEmpty); // null -> [] from List<String>.from(null ?? [])
      expect(entity.deletedAt, isNull);
      expect(entity.institutions, isNull);
      expect(entity.paymentInfo, isNull);
    });

    test('maps null eventGenre to empty list in entity', () {
      final model = makeEventData(eventGenre: null);
      final entity = model.toEntity();
      expect(entity.eventGenre, isEmpty);
    });

    test('maps non-null eventGenre list to entity', () {
      final model = makeEventData(eventGenre: ['Music', 'Festival']);
      final entity = model.toEntity();
      expect(entity.eventGenre, ['Music', 'Festival']);
    });

    test('maps institutions list of ints to entity', () {
      final model = makeEventData(institutions: [1, 2, 3]);
      final entity = model.toEntity();
      expect(entity.institutions, [1, 2, 3]);
    });

    test('maps null institutions to null in entity', () {
      final model = makeEventData(institutions: null);
      final entity = model.toEntity();
      expect(entity.institutions, isNull);
    });

    test('returns Event instance', () {
      final model = makeEventData();
      final entity = model.toEntity();
      expect(entity, isA<Event>());
    });

    test('maps optional image fields when provided', () {
      final model = makeEventData(
        eventCardImage: 'https://img.example.com/card.jpg',
        eventPosterImage: 'https://img.example.com/poster.jpg',
        eventBannerImage: 'https://img.example.com/banner.jpg',
      );
      final entity = model.toEntity();

      expect(entity.eventCardImage, 'https://img.example.com/card.jpg');
      expect(entity.eventPosterImage, 'https://img.example.com/poster.jpg');
      expect(entity.eventBannerImage, 'https://img.example.com/banner.jpg');
    });

    test('maps eventUrl when provided', () {
      final model = makeEventData(eventUrl: 'https://event.example.com');
      final entity = model.toEntity();
      expect(entity.eventUrl, 'https://event.example.com');
    });

    test('maps deletedAt when provided', () {
      final model = makeEventData(deletedAt: '2025-12-31T00:00:00Z');
      final entity = model.toEntity();
      expect(entity.deletedAt, '2025-12-31T00:00:00Z');
    });

    test('institutions with mixed dynamic types parsed as int', () {
      // institutions stored as List<dynamic> in DB
      final model = makeEventData(institutions: [1, 2, 10]);
      final entity = model.toEntity();
      expect(entity.institutions, isA<List<int>>());
      expect(entity.institutions, [1, 2, 10]);
    });
  });

  group('EventEntityHelper (Event.toModel)', () {
    const tEvent = Event(
      id: 'event-model-1',
      eventName: 'Model Test Event',
      eventDescription: 'Testing toModel',
      eventLocation: 'Kisumu',
      startDate: '2025-09-01T09:00:00Z',
      endDate: '2025-09-01T21:00:00Z',
      attendeeCount: 200,
      organizerId: 'org-model',
      createdAt: '2025-02-01T00:00:00Z',
      updatedAt: '2025-02-02T00:00:00Z',
      scope: 'institution',
    );

    test('maps required entity fields to model', () {
      final model = tEvent.toModel();

      expect(model.id, 'event-model-1');
      expect(model.eventName, 'Model Test Event');
      expect(model.eventDescription, 'Testing toModel');
      expect(model.eventLocation, 'Kisumu');
      expect(model.startDate, '2025-09-01T09:00:00Z');
      expect(model.endDate, '2025-09-01T21:00:00Z');
      expect(model.attendeeCount, 200);
      expect(model.organizerId, 'org-model');
      expect(model.createdAt, '2025-02-01T00:00:00Z');
      expect(model.updatedAt, '2025-02-02T00:00:00Z');
      expect(model.scope, 'institution');
    });

    test('maps startDate to model startDate field', () {
      final model = tEvent.toModel();
      expect(model.startDate, '2025-09-01T09:00:00Z');
    });

    test('maps endDate to model endDate field', () {
      final model = tEvent.toModel();
      expect(model.endDate, '2025-09-01T21:00:00Z');
    });

    test('maps scope to model scope field', () {
      final model = tEvent.toModel();
      expect(model.scope, 'institution');
    });

    test('maps null optional fields to null in model', () {
      final model = tEvent.toModel();
      expect(model.eventCardImage, isNull);
      expect(model.eventPosterImage, isNull);
      expect(model.eventBannerImage, isNull);
      expect(model.eventUrl, isNull);
      expect(model.eventGenre, isNull);
      expect(model.deletedAt, isNull);
      expect(model.institutions, isNull);
      expect(model.paymentInfo, isNull);
    });

    test('maps institutions list to model', () {
      final event = tEvent.copyWith(institutions: [5, 10, 15]);
      final model = event.toModel();
      expect(model.institutions, [5, 10, 15]);
    });

    test('maps eventGenre list to model', () {
      final event = tEvent.copyWith(eventGenre: ['Conference', 'Workshop']);
      final model = event.toModel();
      expect(model.eventGenre, ['Conference', 'Workshop']);
    });

    test('returns EventData instance', () {
      final model = tEvent.toModel();
      expect(model, isA<EventData>());
    });

    group('roundtrip (toModel then toEntity)', () {
      test('required fields survive roundtrip', () {
        final model = tEvent.toModel();
        final roundtripped = model.toEntity();

        expect(roundtripped.id, tEvent.id);
        expect(roundtripped.eventName, tEvent.eventName);
        expect(roundtripped.startDate, tEvent.startDate);
        expect(roundtripped.endDate, tEvent.endDate);
        expect(roundtripped.scope, tEvent.scope);
        expect(roundtripped.attendeeCount, tEvent.attendeeCount);
      });

      test('optional institutions survive roundtrip', () {
        final event = tEvent.copyWith(institutions: [1, 2, 3]);
        final model = event.toModel();
        final roundtripped = model.toEntity();
        expect(roundtripped.institutions, [1, 2, 3]);
      });
    });
  });
}