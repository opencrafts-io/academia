import 'package:academia/features/admob/admob.dart';

class AdModel extends AdEntity {
  const AdModel({
    required super.id,
    required super.adUnitId,
    required super.adType,
    super.status = AdStatus.loading,
    super.errorMessage,
    super.metadata,
    super.loadedAt,
    super.shownAt,
  });

  factory AdModel.fromEntity(AdEntity entity) {
    return AdModel(
      id: entity.id,
      adUnitId: entity.adUnitId,
      adType: entity.adType,
      status: entity.status,
      errorMessage: entity.errorMessage,
      metadata: entity.metadata,
      loadedAt: entity.loadedAt,
      shownAt: entity.shownAt,
    );
  }

  AdEntity toEntity() {
    return AdEntity(
      id: id,
      adUnitId: adUnitId,
      adType: adType,
      status: status,
      errorMessage: errorMessage,
      metadata: metadata,
      loadedAt: loadedAt,
      shownAt: shownAt,
    );
  }

  @override
  AdModel copyWith({
    String? id,
    String? adUnitId,
    AdType? adType,
    AdStatus? status,
    String? errorMessage,
    Map<String, dynamic>? metadata,
    DateTime? loadedAt,
    DateTime? shownAt,
  }) {
    return AdModel(
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
