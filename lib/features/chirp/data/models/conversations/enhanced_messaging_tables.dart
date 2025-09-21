import 'package:drift/drift.dart';

@DataClassName('EnhancedConversationData')
class EnhancedConversationTable extends Table {
  TextColumn get conversationId => text()();
  TextColumn get otherUserId => text()();
  TextColumn get otherUserName => text()();
  TextColumn get otherUserEmail => text().nullable()();
  TextColumn get otherUserAvatar => text().nullable()();
  BoolColumn get isOnline => boolean().withDefault(const Constant(false))();
  
  // Last message info
  IntColumn get lastMessageId => integer().nullable()();
  TextColumn get lastMessageContent => text().nullable()();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  
  // Metadata
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get apiUpdatedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {conversationId};
}

@DataClassName('EnhancedMessageData')
class EnhancedMessageTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get apiMessageId => integer().nullable()();
  TextColumn get conversationId => text()();
  TextColumn get senderId => text()();
  TextColumn get senderName => text()();
  TextColumn get senderEmail => text().nullable()();
  TextColumn get senderAvatar => text().nullable()();
  TextColumn get content => text()();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isEdited => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get apiCreatedAt => dateTime().nullable()();
  DateTimeColumn get sentAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  // Status tracking for real-time updates
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, sent, delivered, read, failed
}

@DataClassName('MessageAttachmentData')
class MessageAttachmentsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get messageId => integer()();
  TextColumn get attachmentType => text()(); // 'image', 'file', 'video'
  TextColumn get url => text()();
  TextColumn get fileName => text().nullable()();
  IntColumn get fileSize => integer().nullable()();
  TextColumn get mimeType => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  // Foreign key to message
  @override
  List<Set<Column>> get uniqueKeys => [];
}

@DataClassName('DraftMessageData')
class DraftMessagesTable extends Table {
  TextColumn get conversationId => text()();
  TextColumn get content => text()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {conversationId};
}

@DataClassName('WebSocketConnectionData')
class WebSocketConnectionTable extends Table {
  TextColumn get connectionId => text()();
  TextColumn get state => text()(); // connected, connecting, disconnected, error, reconnecting
  DateTimeColumn get lastConnectedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {connectionId};
}

@DataClassName('OfflineMessageQueueData')
class OfflineMessageQueueTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get conversationId => text()();
  TextColumn get content => text()();
  TextColumn get tempMessageId => text()(); // Temporary ID for correlation
  TextColumn get attachmentPath => text().nullable()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastRetryAt => dateTime().nullable()();
}