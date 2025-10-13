class PaginatedData<T> {
  final List<T> results;
  final int count;
  final String? next;
  final String? previous;

  PaginatedData({
    required this.results,
    required this.count,
    this.next,
    this.previous,
  });

  bool get hasMore {
    return next?.isNotEmpty ?? false;
  }
}