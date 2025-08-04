class Todo {
  final DateTime? completed;
  final bool deleted;
  final DateTime? due;
  final String etag;
  final bool hidden;
  final String id;
  final String kind;
  final String? notes;
  final String owner;
  final String? parent;
  final String position;
  final String selfLink;
  final String status;
  final String title;
  final DateTime? updated;
  final String webViewLink;

  Todo({
    this.completed,
    required this.deleted,
    this.due,
    required this.etag,
    required this.hidden,
    required this.id,
    required this.kind,
    this.notes,
    required this.owner,
    this.parent,
    required this.position,
    required this.selfLink,
    required this.status,
    required this.title,
    this.updated,
    required this.webViewLink,
  });

  Todo copyWith({
    DateTime? completed,
    bool? deleted,
    DateTime? due,
    String? etag,
    bool? hidden,
    String? id,
    String? kind,
    String? notes,
    String? owner,
    String? parent,
    String? position,
    String? selfLink,
    String? status,
    String? title,
    DateTime? updated,
    String? webViewLink,
  }) {
    return Todo(
      completed: completed ?? this.completed,
      deleted: deleted ?? this.deleted,
      due: due ?? this.due,
      etag: etag ?? this.etag,
      hidden: hidden ?? this.hidden,
      id: id ?? this.id,
      kind: kind ?? this.kind,
      notes: notes ?? this.notes,
      owner: owner ?? this.owner,
      parent: parent ?? this.parent,
      position: position ?? this.position,
      selfLink: selfLink ?? this.selfLink,
      status: status ?? this.status,
      title: title ?? this.title,
      updated: updated ?? this.updated,
      webViewLink: webViewLink ?? this.webViewLink,
    );
  }
}
