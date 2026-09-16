import 'package:core/config/flavor.dart';

abstract class RemoteDataSource {
  final FlavorConfig flavor;
  RemoteDataSource({required this.flavor});
}
