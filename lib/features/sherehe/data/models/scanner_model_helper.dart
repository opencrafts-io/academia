import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/domain.dart';

extension ScannerModelHelper on ScannerData {
  Scanner toEntity() => Scanner(
    id: id,
    eventId: eventId,
    userId: userId,
    role: role,
    grantedBy: grantedBy,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    user: user != null ? ShereheUserData.fromJson(user!).toEntity() : null,
  );
}

extension ScannerEntityHelper on Scanner {
  ScannerData toModel() => ScannerData(
    id: id,
    eventId: eventId,
    userId: userId,
    role: role,
    grantedBy: grantedBy,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    user: user?.toModel().toJson(),
  );
}
