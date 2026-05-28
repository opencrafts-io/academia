import 'package:academia/core/core.dart';
import 'package:academia/features/todos/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetTodoTagsParams {
  final String? url;
  const GetTodoTagsParams({this.url});
}

class GetTodoTags extends UseCase<TodoTagPage, GetTodoTagsParams> {
  final TodoTagRepository repository;
  GetTodoTags(this.repository);

  @override
  Future<Either<Failure, TodoTagPage>> call(GetTodoTagsParams params) async {
    return await repository.getTags(url: params.url);
  }
}
