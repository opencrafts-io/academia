import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:todos/src/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetTodoTagsParams {
  final String? url;
  const GetTodoTagsParams({this.url});
}

@injectable
class GetTodoTags extends UseCase<TodoTagPage, GetTodoTagsParams> {
  final TodoTagRepository repository;
  GetTodoTags(this.repository);

  @override
  Future<Either<Failure, TodoTagPage>> call(GetTodoTagsParams params) async {
    return await repository.getTags(url: params.url);
  }
}
