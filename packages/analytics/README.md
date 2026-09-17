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

Every event carries `analytics_schema_version: 1` and an `event_owner`. Names
are lowercase snake case and are created only through `AnalyticsEvent`.

| Owner | Events |
| --- | --- |
| Acquisition | `acquisition_started`, `sign_in_completed` |
| Activation | `activation_completed`, institution search/link events, `screen_viewed` |
| Learning | `learning_action_completed` |
| Conversion | `paywall_viewed`, `checkout_started` |
| Revenue | `purchase_completed`, `entitlement_granted`, renewal/cancellation |
| Retention | `retention_qualified`, `sign_out_completed` |
| Platform | `permission_requested` |

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
Changing an event name or property requires a new schema version, an owner,
and a temporary comparison of old and new event counts before retiring the old
dashboard query.

## Development

```bash
flutter test
dart run build_runner build
```
