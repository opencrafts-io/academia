import 'package:drift/drift.dart';
import './institution.dart';

class InstitutionFeeTransaction extends Table {
  IntColumn get id => integer().nullable()();

  IntColumn get institution =>
      integer().references(Institution, #institutionId)();

  @JsonKey("reference_number")
  TextColumn get referenceNumber =>
      text().nullable().withLength(min: 1, max: 255)();

  @JsonKey("running_balance")
  RealColumn get runningBalance => real().withDefault(Constant(0)).nullable()();

  @JsonKey("debit")
  RealColumn get debit => real().nullable().withDefault(Constant(0.0))();

  @JsonKey("credit")
  RealColumn get credit => real().nullable().withDefault(Constant(0.0))();

  @JsonKey("posting_date")
  DateTimeColumn get postingDate => dateTime().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get title => text().nullable()();

  TextColumn get currency => text().nullable().withDefault(Constant("KES"))();

  @override
  Set<Column<Object>>? get primaryKey => {institution, referenceNumber};
}
