import 'package:academia/database/database.dart';
import 'package:academia/features/institution/data/models/institution_model_helper.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/entities/event.dart';

extension EventModelHelper on EventData {
  Event toEntity() => Event(
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
    eventGenre: List<String>.from(eventGenre ?? []),
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    scope: scope,
    institutions: institutions
        ?.map((institution) => InstitutionData.fromJson(institution).toEntity())
        .toList(),
    paymentInfo: paymentInfo != null
        ? PaymentInfoData.fromJson(paymentInfo!).toEntity()
        : null,
  );
}

extension EventEntityHelper on Event {
  EventData toModel() => EventData(
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
    eventGenre: eventGenre,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    scope: scope,
    institutions: institutions
        ?.map((institution) => institution.toData().toJson())
        .toList(),
    paymentInfo: paymentInfo?.toModel().toJson(),
  );
}
