enum AnalyticsEventOwner {
  acquisition,
  activation,
  learning,
  conversion,
  revenue,
  retention,
  platform,
}

enum AnalyticsEventName {
  acquisitionStarted('acquisition_started'),
  activationCompleted('activation_completed'),
  learningActionCompleted('learning_action_completed'),
  paywallViewed('paywall_viewed'),
  checkoutStarted('checkout_started'),
  purchaseCompleted('purchase_completed'),
  entitlementGranted('entitlement_granted'),
  subscriptionRenewed('subscription_renewed'),
  subscriptionCancelled('subscription_cancelled'),
  retentionQualified('retention_qualified'),
  screenViewed('screen_viewed'),
  signInCompleted('sign_in_completed'),
  signOutCompleted('sign_out_completed'),
  institutionSearchCompleted('institution_search_completed'),
  institutionLinked('institution_linked'),
  institutionUnlinked('institution_unlinked'),
  permissionRequested('permission_requested');

  const AnalyticsEventName(this.wireName);

  final String wireName;
}

enum AnalyticsSignInMethod { apple, google, provider, reviewer, spotify }

enum AnalyticsPermissionCapability {
  location,
  notifications,
  camera,
  storage,
  preciseAlarms,
}

enum AnalyticsPermissionOutcome { granted, denied, permanentlyDenied }

class AnalyticsEvent {
  const AnalyticsEvent._({
    required this.name,
    required this.owner,
    this.properties = const {},
  });

  static const schemaVersion = 1;

  final AnalyticsEventName name;
  final AnalyticsEventOwner owner;
  final Map<String, Object> properties;

  Map<String, Object> get payload => {
    'analytics_schema_version': schemaVersion,
    'event_owner': owner.name,
    ...properties,
  };

  factory AnalyticsEvent.signInCompleted(AnalyticsSignInMethod method) {
    return AnalyticsEvent._(
      name: AnalyticsEventName.signInCompleted,
      owner: AnalyticsEventOwner.acquisition,
      properties: {'sign_in_method': method.name},
    );
  }

  factory AnalyticsEvent.signOutCompleted() => const AnalyticsEvent._(
    name: AnalyticsEventName.signOutCompleted,
    owner: AnalyticsEventOwner.retention,
  );

  factory AnalyticsEvent.institutionSearchCompleted() => const AnalyticsEvent._(
    name: AnalyticsEventName.institutionSearchCompleted,
    owner: AnalyticsEventOwner.activation,
  );

  factory AnalyticsEvent.institutionLinked() => const AnalyticsEvent._(
    name: AnalyticsEventName.institutionLinked,
    owner: AnalyticsEventOwner.activation,
  );

  factory AnalyticsEvent.institutionUnlinked() => const AnalyticsEvent._(
    name: AnalyticsEventName.institutionUnlinked,
    owner: AnalyticsEventOwner.retention,
  );

  factory AnalyticsEvent.permissionRequested({
    required AnalyticsPermissionCapability capability,
    required AnalyticsPermissionOutcome outcome,
  }) {
    return AnalyticsEvent._(
      name: AnalyticsEventName.permissionRequested,
      owner: AnalyticsEventOwner.platform,
      properties: {
        'permission_capability': capability.name,
        'permission_outcome': outcome.name,
      },
    );
  }

  factory AnalyticsEvent.paywallViewed() => const AnalyticsEvent._(
    name: AnalyticsEventName.paywallViewed,
    owner: AnalyticsEventOwner.conversion,
  );

  factory AnalyticsEvent.checkoutStarted() => const AnalyticsEvent._(
    name: AnalyticsEventName.checkoutStarted,
    owner: AnalyticsEventOwner.conversion,
  );

  factory AnalyticsEvent.screenViewed(String route) {
    return AnalyticsEvent._(
      name: AnalyticsEventName.screenViewed,
      owner: AnalyticsEventOwner.activation,
      properties: {'screen_route': route},
    );
  }
}

class AnalyticsIdentity {
  const AnalyticsIdentity({
    required this.userId,
    required this.hasCompletedOnboarding,
  });

  final String userId;
  final bool hasCompletedOnboarding;

  Map<String, Object> get properties => {
    'analytics_schema_version': AnalyticsEvent.schemaVersion,
    'has_completed_onboarding': hasCompletedOnboarding,
  };
}
