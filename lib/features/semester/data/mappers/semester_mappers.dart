import 'package:academia/database/database.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:drift/drift.dart';

extension SemesterMapper on SemesterData {
  SemesterEntity toEntity() => SemesterEntity(
    id: id,
    name: name,
    startDate: startDate,
    endDate: endDate,
  );
}

extension SemesterEntityMapper on SemesterEntity {
  SemesterData toData() => SemesterData(
    id: id ?? 0,
    name: name,
    startDate: startDate,
    endDate: endDate,
  );

  SemesterCompanion toCompanion() => SemesterCompanion(
    id: id == null ? const Value.absent() : Value(id!),
    name: Value(name),
    startDate: Value(startDate),
    endDate: Value(endDate),
  );
}
