import 'package:academia/core/data/json_converter.dart';
import 'package:drift/drift.dart';

class Institution extends Table {
  @JsonKey("institution_id")
  IntColumn get institutionId => integer().named('institution_id')();

  TextColumn get name => text()();
  @JsonKey("web_pages")
  TextColumn get webPages =>
      text().nullable().map(const StringListConverter())();
  TextColumn get domains =>
      text().nullable().map(const StringListConverter())();
  @JsonKey("alpha_two_code")
  TextColumn get alphaTwoCode => text().nullable().named('alpha_two_code')();
  TextColumn get country => text().nullable()();
  @JsonKey("state_province")
  TextColumn get stateProvince => text().nullable().named('state_province')();

  @override
  Set<Column> get primaryKey => {institutionId};
}
