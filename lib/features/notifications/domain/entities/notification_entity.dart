import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final bool isRead;
  final String? category;
  final String? actionUrl;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    this.data,
    required this.createdAt,
    this.isRead = false,
    this.category,
    this.actionUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        imageUrl,
        data,
        createdAt,
        isRead,
        category,
        actionUrl,
      ];

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    String? imageUrl,
    Map<String, dynamic>? data,
    DateTime? createdAt,
    bool? isRead,
    String? category,
    String? actionUrl,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      category: category ?? this.category,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }
}

