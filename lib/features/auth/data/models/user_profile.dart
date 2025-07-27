import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('UserProfileData')
class UserProfile extends Table with TableMixin {
  TextColumn get name => text()();
  TextColumn get email => text()();
  @JsonKey('terms_accepted')
  BoolColumn get termsAccepted => boolean().withDefault(Constant(false))();
  @JsonKey('onboarded')
  BoolColumn get onboarded => boolean().withDefault(Constant(false))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
