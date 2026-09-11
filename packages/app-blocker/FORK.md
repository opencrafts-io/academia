# Academia fork of `app_blocker`

Base: [`app_blocker` 2.2.0](https://pub.dev/packages/app_blocker).

This fork preserves the upstream Dart API and platform implementations. Its
only behavioral change is on Android: when the accessibility service detects a
blocked launch, it opens Academia's internal app link at
`https://academia.opencrafts.io/lock-in/blocked` instead of the upstream
`BlockedAppActivity`.

The deep link includes the blocked package name and timestamp. Attempt events
continue to flow through the existing Flutter event channel for local Lock In
analytics.

Keep fork changes narrow and reconcile this file whenever the upstream package
is upgraded.
