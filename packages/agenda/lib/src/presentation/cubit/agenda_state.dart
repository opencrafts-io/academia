import '../../domain/entities/agenda_event.dart';

class AgendaState {
  const AgendaState({
    this.events = const [],
    this.count = 0,
    this.page = 1,
    this.pageSize = 20,
    this.next,
    this.previous,
    this.startDate,
    this.endDate,
    this.isLoading = false,
    this.isLoadingPage = false,
    this.isSaving = false,
    this.error,
  });

  final List<AgendaEvent> events;
  final int count;
  final int page;
  final int pageSize;
  final String? next;
  final String? previous;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isLoading;
  final bool isLoadingPage;
  final bool isSaving;
  final String? error;

  bool get hasNextPage => next != null;
  bool get hasPreviousPage => previous != null;

  AgendaState copyWith({
    List<AgendaEvent>? events,
    int? count,
    int? page,
    int? pageSize,
    String? next,
    String? previous,
    DateTime? startDate,
    DateTime? endDate,
    bool? isLoading,
    bool? isLoadingPage,
    bool? isSaving,
    String? error,
    bool clearNext = false,
    bool clearPrevious = false,
    bool clearError = false,
    bool clearDates = false,
  }) {
    return AgendaState(
      events: events ?? this.events,
      count: count ?? this.count,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      next: clearNext ? null : next ?? this.next,
      previous: clearPrevious ? null : previous ?? this.previous,
      startDate: clearDates ? null : startDate ?? this.startDate,
      endDate: clearDates ? null : endDate ?? this.endDate,
      isLoading: isLoading ?? this.isLoading,
      isLoadingPage: isLoadingPage ?? this.isLoadingPage,
      isSaving: isSaving ?? this.isSaving,
      error: clearError ? null : error ?? this.error,
    );
  }
}
