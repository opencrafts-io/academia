class PaginatedResult<T> {
  final List<T> results;
  final int currentPage;
  final String? next;
  final String? previous;

  PaginatedResult({
    required this.results,
    required this.currentPage,
    this.next,
    this.previous,
  });

  bool get hasMore {
    return next?.isNotEmpty ?? false;
  }
}
