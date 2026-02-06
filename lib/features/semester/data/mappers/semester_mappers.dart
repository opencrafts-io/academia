import 'package:academia/database/database.dart';
import 'package:academia/features/semester/domain/domain.dart';

extension SemesterMapper on SemesterData {
  SemesterEntity toEntity() => SemesterEntity(
    id: id,
    name: name,
    startDate: startDate,
    endDate: endDate,
  );
}

extension SemesterEntityMapper on SemesterEntity {
  SemesterData toData() =>
      SemesterData(id: id, name: name, startDate: startDate, endDate: endDate);
}
