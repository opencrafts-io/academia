import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/invite.dart';

extension InviteModelHelper on InviteData {
  Invite toEntity() => Invite(
    id: id,
    eventId: eventId,
    token: token,
    expiresAt: expiresAt,
    maxUses: maxUses,
    usedCount: usedCount,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension InviteEntityHelper on Invite {
  InviteData toModel() => InviteData(
    id: id,
    eventId: eventId,
    token: token,
    expiresAt: expiresAt,
    maxUses: maxUses,
    usedCount: usedCount,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
