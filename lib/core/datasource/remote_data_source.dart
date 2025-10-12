import 'package:academia/config/config.dart';

abstract class RemoteDataSource {
  final FlavorConfig flavor;
  RemoteDataSource({required this.flavor});
}
