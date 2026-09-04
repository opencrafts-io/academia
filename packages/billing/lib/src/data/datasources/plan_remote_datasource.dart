import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlanRemoteDatasource {
  final ApiClient apiClient;
  PlanRemoteDatasource({required this.apiClient});

}
