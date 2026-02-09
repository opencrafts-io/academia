import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String eventName;
  final String eventDescription;
  final String? eventUrl;
  final String eventLocation;
  final String eventDate;
  final int attendeeCount;
  final String organizerId;
  final String? eventCardImage;
  final String? eventPosterImage;
  final String? eventBannerImage;
  final List<String>? eventGenre;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final PaymentInfo? paymentInfo;

  const Event({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    this.eventUrl,
    required this.eventLocation,
    required this.eventDate,
    required this.attendeeCount,
    required this.organizerId,
    this.eventCardImage,
    this.eventPosterImage,
    this.eventBannerImage,
    this.eventGenre,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.paymentInfo,
  });

  Event copyWith({
    String? id,
    String? eventName,
    String? eventDescription,
    String? eventUrl,
    String? eventLocation,
    String? eventDate,
    int? attendeeCount,
    String? organizerId,
    String? eventCardImage,
    String? eventPosterImage,
    String? eventBannerImage,
    List<String>? eventGenre,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    PaymentInfo? paymentInfo,
  }) {
    return Event(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventDescription: eventDescription ?? this.eventDescription,
      eventUrl: eventUrl ?? this.eventUrl,
      eventLocation: eventLocation ?? this.eventLocation,
      eventDate: eventDate ?? this.eventDate,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      organizerId: organizerId ?? this.organizerId,
      eventCardImage: eventCardImage ?? this.eventCardImage,
      eventPosterImage: eventPosterImage ?? this.eventPosterImage,
      eventBannerImage: eventBannerImage ?? this.eventBannerImage,
      eventGenre: eventGenre ?? this.eventGenre,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
    eventDate,
    attendeeCount,
    organizerId,
    eventCardImage,
    eventPosterImage,
    eventBannerImage,
    eventGenre,
    createdAt,
    updatedAt,
    deletedAt,
    paymentInfo,
  ];

  @override
  bool? get stringify => true;
}
