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
  featureActionRecorded('feature_action_recorded'),
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

enum AnalyticsSignInMethod {
  apple,
  google,
  provider,
  reviewer,
  spotify,
  password,
}

enum AnalyticsPermissionCapability {
  location,
  notifications,
  camera,
  storage,
  preciseAlarms,
}

enum AnalyticsPermissionOutcome { granted, denied, permanentlyDenied }

enum AnalyticsFeaturePackage {
  studyTools('study_tools'),
  todos('todos'),
  agenda('agenda');

  const AnalyticsFeaturePackage(this.wireName);
  final String wireName;
}

enum AnalyticsFeatureAction {
  materialOpened('material_opened'),
  materialUploaded('material_uploaded'),
  materialDeleted('material_deleted'),
  questionGenerationStarted('question_generation_started'),
  podcastGenerationStarted('podcast_generation_started'),
  practiceOpened('practice_opened'),
  podcastPlayStarted('podcast_play_started'),
  podcastDownloadCompleted('podcast_download_completed'),
  taskCreated('task_created'),
  taskUpdated('task_updated'),
  taskDeleted('task_deleted'),
  taskCompleted('task_completed'),
  taskReopened('task_reopened'),
  taskListCreated('task_list_created'),
  taskListUpdated('task_list_updated'),
  taskListDeleted('task_list_deleted'),
  tagCreated('tag_created'),
  tagUpdated('tag_updated'),
  tagDeleted('tag_deleted'),
  eventCreated('event_created'),
  eventUpdated('event_updated'),
  eventDeleted('event_deleted');

  const AnalyticsFeatureAction(this.wireName);
  final String wireName;
}

class AnalyticsEvent {
  const AnalyticsEvent._({
    required this.name,
    required this.owner,
    this.properties = const {},
  });

  static const schemaVersion = 2;

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

  factory AnalyticsEvent.screenViewed(
    String route, {
    AnalyticsFeaturePackage? featurePackage,
  }) {
    return AnalyticsEvent._(
      name: AnalyticsEventName.screenViewed,
      owner: featurePackage == null
          ? AnalyticsEventOwner.activation
          : AnalyticsEventOwner.learning,
      properties: {
        'screen_route': route,
        if (featurePackage != null)
          'feature_package': featurePackage.wireName,
      },
    );
  }

  factory AnalyticsEvent.featureAction({
    required AnalyticsFeaturePackage featurePackage,
    required AnalyticsFeatureAction action,
  }) => AnalyticsEvent._(
    name: AnalyticsEventName.featureActionRecorded,
    owner: AnalyticsEventOwner.learning,
    properties: {
      'feature_package': featurePackage.wireName,
      'feature_action': action.wireName,
    },
  );
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
