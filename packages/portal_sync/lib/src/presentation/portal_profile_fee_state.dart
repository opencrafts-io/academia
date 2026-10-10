import '../domain/entities/portal_profile_fee_draft.dart';

enum PortalProfileFeePhase {
  idle,
  observing,
  analyzing,
  review,
  saving,
  saved,
  blocked,
  error,
}

class PortalProfileFeeState {
  const PortalProfileFeeState({
    required this.phase,
    this.message,
    this.draft,
    this.profileFieldsCount = 0,
    this.feeLineItemsCount = 0,
    this.fromCache = false,
    this.error,
    this.isBusy = false,
  });

  final PortalProfileFeePhase phase;
  final String? message;
  final PortalProfileFeeDraft? draft;
  final int profileFieldsCount;
  final int feeLineItemsCount;
  final bool fromCache;
  final String? error;
  final bool isBusy;

  PortalProfileFeeState copyWith({
    PortalProfileFeePhase? phase,
    String? message,
    PortalProfileFeeDraft? draft,
    bool clearDraft = false,
    int? profileFieldsCount,
    int? feeLineItemsCount,
    bool? fromCache,
    String? error,
    bool clearError = false,
    bool? isBusy,
  }) => PortalProfileFeeState(
    phase: phase ?? this.phase,
    message: message ?? this.message,
    draft: clearDraft ? null : draft ?? this.draft,
    profileFieldsCount: profileFieldsCount ?? this.profileFieldsCount,
    feeLineItemsCount: feeLineItemsCount ?? this.feeLineItemsCount,
    fromCache: fromCache ?? this.fromCache,
    error: clearError ? null : error ?? this.error,
    isBusy: isBusy ?? this.isBusy,
  );
}
