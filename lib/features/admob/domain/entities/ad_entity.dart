import 'package:equatable/equatable.dart';

enum AdType {
  banner,
  interstitial,
  rewarded,
  native,
}

enum AdStatus {
  loading,
  loaded,
  failed,
  shown,
  dismissed,
  rewarded,
}

class AdEntity extends Equatable {
  final String id;
  final String adUnitId;
  final AdType adType;
  final AdStatus status;
  final String? errorMessage;
  final Map<String, dynamic>? metadata;
  final DateTime? loadedAt;
  final DateTime? shownAt;

  const AdEntity({
    required this.id,
    required this.adUnitId,
    required this.adType,
    this.status = AdStatus.loading,
    this.errorMessage,
    this.metadata,
    this.loadedAt,
    this.shownAt,
  });

  @override
  List<Object?> get props => [
        id,
        adUnitId,
        adType,
        status,
        errorMessage,
        metadata,
        loadedAt,
        shownAt,
      ];

  AdEntity copyWith({
    String? id,
    String? adUnitId,
    AdType? adType,
    AdStatus? status,
    String? errorMessage,
    Map<String, dynamic>? metadata,
    DateTime? loadedAt,
    DateTime? shownAt,
  }) {
    return AdEntity(
      id: id ?? this.id,
      adUnitId: adUnitId ?? this.adUnitId,
      adType: adType ?? this.adType,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      metadata: metadata ?? this.metadata,
      loadedAt: loadedAt ?? this.loadedAt,
      shownAt: shownAt ?? this.shownAt,
    );
  }
}
