# In-app update

This private package evaluates Academia release-update campaigns and presents
the matching required or optional prompt. It has no dependency on PostHog; the
host supplies the remote configuration source.

## PostHog configuration

The production host reads the `app-upgrade-config` feature-flag payload. Use
PostHog feature-flag targeting for cohorts, rollout percentage, or campaign
audiences. The app evaluates only the selected payload for its platform.

Use this v2 payload shape:

```json
{
  "schema_version": 2,
  "platforms": {
    "android": {
      "store_url": "https://play.google.com/store/apps/details?id=io.opencrafts.academia",
      "campaigns": [
        {
          "id": "android-3-5-optional",
          "target_version": "3.5.0",
          "mode": "optional",
          "title": "A newer Academia is ready",
          "message": "Update when you are ready."
        },
        {
          "id": "android-3-4-required",
          "target_version": "3.4.0",
          "mode": "required",
          "title": "Update required",
          "message": "This version is no longer supported."
        }
      ]
    }
  }
}
```

A campaign applies when the installed semantic version is lower than its
`target_version`. Required campaigns take priority over optional campaigns;
within a mode, the highest target version wins. `store_url` is optional on a
campaign and defaults to the platform value supplied by the app. URLs must use
HTTPS and an official `play.google.com` or `apps.apple.com` host.

## Safe migration from v1

Keep the existing top-level v1 fields in the same payload while old app
versions remain installed. Older clients ignore `schema_version` and use those
fields; new clients choose v2 first and fall back to v1 if v2 is missing or
invalid.

```json
{
  "message": "This version is no longer supported.",
  "android": {
    "min_version": "3.4.0",
    "is_critical": true
  },
  "ios": {
    "min_version": "3.4.0",
    "is_critical": true
  }
}
```

For a required migration, mirror the required v2 campaign threshold in the
v1 `min_version` field. Do not remove v1 fields until all supported app builds
include the v2 evaluator.

## Development

Run the package tests with:

```bash
flutter test
```

When changing injectable annotations, regenerate its dependency configuration:

```bash
dart run build_runner build
```
