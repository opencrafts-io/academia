import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String eventName;
  final String eventDescription;
  final String? eventUrl;
  final String eventLocation;
  final String startDate;
  final String endDate;
  final int attendeeCount;
  final String organizerId;
  final String? eventCardImage;
  final String? eventPosterImage;
  final String? eventBannerImage;
  final List<String>? eventGenre;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String scope;
  final List<int>? institutions;
  final PaymentInfo? paymentInfo;

  const Event({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    this.eventUrl,
    required this.eventLocation,
    required this.startDate,
    required this.endDate,
    required this.attendeeCount,
    required this.organizerId,
    this.eventCardImage,
    this.eventPosterImage,
    this.eventBannerImage,
    this.eventGenre,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.scope,
    this.institutions,
    this.paymentInfo,
  });

  Event copyWith({
    String? id,
    String? eventName,
    String? eventDescription,
    String? eventUrl,
    String? eventLocation,
    String? startDate,
    String? endDate,
    int? attendeeCount,
    String? organizerId,
    String? eventCardImage,
    String? eventPosterImage,
    String? eventBannerImage,
    List<String>? eventGenre,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? scope,
    List<int>? institutions,
    PaymentInfo? paymentInfo,
  }) {
    return Event(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventDescription: eventDescription ?? this.eventDescription,
      eventUrl: eventUrl ?? this.eventUrl,
      eventLocation: eventLocation ?? this.eventLocation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      organizerId: organizerId ?? this.organizerId,
      eventCardImage: eventCardImage ?? this.eventCardImage,
      eventPosterImage: eventPosterImage ?? this.eventPosterImage,
      eventBannerImage: eventBannerImage ?? this.eventBannerImage,
      eventGenre: eventGenre ?? this.eventGenre,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      scope: scope ?? this.scope,
      institutions: institutions ?? this.institutions,
      paymentInfo: paymentInfo ?? this.paymentInfo,
    );
  }

  @override
  List<Object?> get props => [
    id,
    eventName,
    eventDescription,
    eventUrl,
    eventLocation,
    startDate,
    endDate,
    attendeeCount,
    organizerId,
    eventCardImage,
    eventPosterImage,
    eventBannerImage,
    eventGenre,
    createdAt,
    updatedAt,
    deletedAt,
    scope,
    institutions,
    paymentInfo,
  ];

  @override
  bool? get stringify => true;
}
