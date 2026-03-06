part of 'all_scanners_bloc.dart';

abstract class AllScannersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllScanners extends AllScannersEvent {
  final String eventId;
  final int page;
  final int limit;

  FetchAllScanners({
    required this.eventId,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [eventId, page, limit];
}
