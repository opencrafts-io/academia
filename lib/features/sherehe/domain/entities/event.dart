import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String eventName;
  final String eventDescription;
  final String? eventUrl;
  final String eventLocation;
  final String eventDate;
  final String organizerId;
  final String? eventCardImage;
  final String? eventPosterImage;
  final String? eventBannerImage;
  final String? eventGenre;
  final bool deleteTag;
  final String createdAt;
  final String updatedAt;

  const Event({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    this.eventUrl,
    required this.eventLocation,
    required this.eventDate,
    required this.organizerId,
    this.eventCardImage,
    this.eventPosterImage,
    this.eventBannerImage,
    this.eventGenre,
    required this.deleteTag,
    required this.createdAt,
    required this.updatedAt,
  });

  Event copyWith({
    String? id,
    String? eventName,
    String? eventDescription,
    String? eventUrl,
    String? eventLocation,
    String? eventDate,
    String? organizerId,
    String? eventCardImage,
    String? eventPosterImage,
    String? eventBannerImage,
    String? eventGenre,
    bool? deleteTag,
    String? createdAt,
    String? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      eventDescription: eventDescription ?? this.eventDescription,
      eventUrl: eventUrl ?? this.eventUrl,
      eventLocation: eventLocation ?? this.eventLocation,
      eventDate: eventDate ?? this.eventDate,
      organizerId: organizerId ?? this.organizerId,
      eventCardImage: eventCardImage ?? this.eventCardImage,
      eventPosterImage: eventPosterImage ?? this.eventPosterImage,
      eventBannerImage: eventBannerImage ?? this.eventBannerImage,
      eventGenre: eventGenre ?? this.eventGenre,
      deleteTag: deleteTag ?? this.deleteTag,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    organizerId,
    eventCardImage,
    eventPosterImage,
    eventBannerImage,
    eventGenre,
    deleteTag,
    createdAt,
    updatedAt,
  ];

  @override
  bool? get stringify => true;
}
