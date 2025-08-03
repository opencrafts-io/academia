import 'package:academia/database/database.dart';
import 'package:academia/features/todos/todos.dart';

extension TodoHelper on TodoData {
  Todo toEntity() => Todo(
    deleted: deleted,
    etag: etag,
    hidden: hidden,
    id: id,
    kind: kind,
    owner: owner,
    position: position,
    selfLink: selfLink,
    status: status,
    title: title,
    webViewLink: webViewLink,
    notes: notes,
    completed: completed,
    due: due,
    parent: parent,
    updated: updated,
  );
}

extension TodoEntityHelper on Todo {
  TodoData toModel() => TodoData(
    deleted: deleted,
    etag: etag,
    hidden: hidden,
    id: id,
    kind: kind,
    owner: owner,
    position: position,
    selfLink: selfLink,
    status: status,
    title: title,
    webViewLink: webViewLink,
    notes: notes,
    completed: completed,
    due: due,
    parent: parent,
    updated: updated,
  );
}
