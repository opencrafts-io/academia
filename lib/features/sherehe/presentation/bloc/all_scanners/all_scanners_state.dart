part of 'all_scanners_bloc.dart';

abstract class AllScannersState extends Equatable {
  const AllScannersState();

  @override
  List<Object?> get props => [];
}

class AllScannersStateInitial extends AllScannersState {}

class AllScannersStateLoading extends AllScannersState {}

class AllScannersStatePaginationLoading extends AllScannersState {
  final List<Scanner> existingScanners;
  final bool hasMore;

  const AllScannersStatePaginationLoading({
    required this.existingScanners,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingScanners, hasMore];
}

class AllScannersStateLoaded extends AllScannersState {
  final List<Scanner> scanners;
  final bool hasMore;

  const AllScannersStateLoaded({required this.scanners, this.hasMore = false});
  AllScannersStateLoaded copyWith({List<Scanner>? scanners, bool? hasMore}) {
    return AllScannersStateLoaded(
      scanners: scanners ?? this.scanners,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [scanners, hasMore];
}

class AllScannersStateError extends AllScannersState {
  final String message;

  const AllScannersStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllScannersStatePaginationError extends AllScannersState {
  final List<Scanner> existingScanners;
  final String message;
  final bool hasMore;

  const AllScannersStatePaginationError({
    required this.existingScanners,
    required this.message,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingScanners, message, hasMore];
}