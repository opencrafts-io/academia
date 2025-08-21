import 'package:academia/features/notifications/notifications.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    super.imageUrl,
    super.data,
    required super.createdAt,
    super.isRead = false,
    super.category,
    super.actionUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['imageUrl'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      category: json['category'] as String?,
      actionUrl: json['actionUrl'] as String?,
    );
  }

  factory NotificationModel.fromTable(dynamic table) {
    return NotificationModel(
      id: table.id,
      title: table.title,
      body: table.body,
      imageUrl: table.imageUrl,
      data: table.data,
      createdAt: table.createdAt,
      isRead: table.isRead,
      category: table.category,
      actionUrl: table.actionUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      'category': category,
      'actionUrl': actionUrl,
    };
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      imageUrl: entity.imageUrl,
      data: entity.data,
      createdAt: entity.createdAt,
      isRead: entity.isRead,
      category: entity.category,
      actionUrl: entity.actionUrl,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      imageUrl: imageUrl,
      data: data,
      createdAt: createdAt,
      isRead: isRead,
      category: category,
      actionUrl: actionUrl,
    );
  }

  dynamic toTable() {
    // This will be properly typed after the database is generated
    return {
      'id': id,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'data': data,
      'createdAt': createdAt,
      'isRead': isRead,
      'category': category,
      'actionUrl': actionUrl,
    };
  }
}
