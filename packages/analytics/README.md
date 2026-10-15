# Analytics

This private package owns Academia's product-event taxonomy and PostHog
boundary. Product code records typed `AnalyticsEvent` values through
`AnalyticsTracker`; it must not import `posthog_flutter` or send raw payloads.

## Host setup

Configure the package once in the composition root. The host decides whether
analytics is enabled for the current flavor; PostHog itself remains internal to
this package.

```dart
configureAnalyticsDependencies(
  getIt,
  analyticsGateway: flavorConfig.isProduction
      ? PosthogAnalyticsGateway()
      : const DisabledAnalyticsGateway(),
);
```

Use `FeatureFlagReader` for remote configuration. Feature-flag reads suppress
exposure events because they are configuration, not business analytics.

## Event contract

Every event carries `analytics_schema_version: 2` and an `event_owner`. Names
are lowercase snake case and are created only through `AnalyticsEvent`.

| Owner | Events |
| --- | --- |
| Acquisition | `acquisition_started`, `sign_in_completed` |
| Activation | `activation_completed`, institution search/link events, general `screen_viewed` |
| Learning | `learning_action_completed`, package `screen_viewed`, `feature_action_recorded` |
| Conversion | `paywall_viewed`, `checkout_started` |
| Revenue | `purchase_completed`, `entitlement_granted`, renewal/cancellation |
| Retention | `retention_qualified`, `sign_out_completed` |
| Platform | `permission_requested` |

Package usage is recorded as `feature_action_recorded` with `feature_package`
and `feature_action` properties. Current package values are `study_tools`,
`todos`, and `agenda`. Page views use `screen_viewed` with the same package
property when the route belongs to one of those packages. Actions describe
successful user operations or meaningful starts; background loads and polling
are not recorded.

The mobile client currently records sign-in/out, institution, permission,
paywall, checkout-session, and named page-route milestones. Purchases,
entitlements, renewals, and cancellations are server-authoritative: emit them
from backend payment or subscription processing, not from client guesses.

## Privacy and dashboard governance

`AnalyticsIdentity` allows only the account identifier and onboarding state.
Do not add email, name, phone number, free-form search text, account IDs in
event properties, or payment details. Add a typed event field only when it is
needed by an owned dashboard and is safe to collect.

Dashboards group events by `event_owner` and `analytics_schema_version`.
Package dashboards should also filter on `feature_package` and group by
`feature_action`.
Changing an event name or property requires a new schema version, an owner,
and a temporary comparison of old and new event counts before retiring the old
dashboard query.

## Development

```bash
flutter test
dart run build_runner build
```
