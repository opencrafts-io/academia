# Replace Firebase Crashlytics with PostHog

Date: 2026-03-21

## Status

Proposed

## Context

Firebase Crashlytics only provides crash reporting with no broader product context. When an error occurs, there is no way to understand what the user was doing leading up to the crash, who was affected, or how errors correlate with user behaviour. Getting any meaningful analytics requires adding a separate Firebase service, increasing SDK overhead and deepening vendor lock-in. We also have no control over where our data lives.

## Decision

Migrate from Firebase Crashlytics to PostHog for error monitoring and product analytics. PostHog consolidates crash capture, user analytics, session replay, and feature flags into a single tool with an official Flutter SDK. It is self-hostable, giving us ownership of our data, and is more cost-effective at scale.

## Consequences

**Easier:**
- Correlating errors with user behaviour and journeys in one dashboard
- Managing a single SDK instead of multiple Firebase services
- Controlling our data through self-hosting if needed
- Accessing product analytics, session replay, and feature flags without additional tooling

**More difficult:**
- Teams familiar with the Crashlytics dashboard will need to ramp up on PostHog
- If other Firebase services are in use, the Firebase dependency cannot be fully removed yet
