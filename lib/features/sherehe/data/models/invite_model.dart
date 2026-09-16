import 'package:drift/drift.dart';

@DataClassName('InviteData')
class InviteTable extends Table {
  TextColumn get id => text()();

  @JsonKey('event_id')
  TextColumn get eventId => text().nullable()();

  @JsonKey('ticket_id')
  TextColumn get ticketId => text().nullable()();

  @JsonKey('token')
  TextColumn get token => text()();

  @JsonKey('expires_at')
  TextColumn get expiresAt => text()();

  @JsonKey('max_uses')
  IntColumn get maxUses => integer()();

  @JsonKey('used_count')
  IntColumn get usedCount => integer()();

  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @JsonKey('updated_at')
  TextColumn get updatedAt => text()();
}
