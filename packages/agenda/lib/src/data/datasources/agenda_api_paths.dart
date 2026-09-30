import 'package:core/config/flavor.dart';

class AgendaApiPaths {
  const AgendaApiPaths(this._flavor);

  final FlavorConfig _flavor;

  String get collection => '/$_servicePrefix/agenda/';
  String get create => '/$_servicePrefix/agenda/add';
  String update(String id) => '/$_servicePrefix/agenda/update/$id';
  String delete(String id) => '/$_servicePrefix/agenda/delete/$id';

  String get _servicePrefix => switch (_flavor.flavor) {
    Flavor.production => 'keepup',
    Flavor.staging => 'qa-keepup',
    Flavor.development => 'dev-keepup',
  };
}
