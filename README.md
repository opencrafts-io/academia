<p align="center">
  <img src="assets/icons/academia-logo-variant-1.png" width="320" alt="Academia logo" />
</p>

<h1 align="center">Academia - For Campus Students</h1>

<p align="center">
  Your campus companion for planning, studying, connecting, and building the
  student life you want.
</p>

<p align="center">
  A Flutter app, proudly made in Kenya for campus students everywhere.
</p>

<p align="center">
  <a href="https://play.google.com/store/apps/details?id=io.opencrafts.academia&amp;hl=en&amp;gl=KE">
    <img src="https://img.shields.io/badge/Get_it_on-Google_Play-414141?style=for-the-badge&amp;logo=googleplay&amp;logoColor=white" alt="Get Academia on Google Play" />
  </a>
  <a href="https://apps.apple.com/us/app/academia-for-campus-students/id6753922995">
    <img src="https://img.shields.io/badge/Download_on_the-App_Store-000000?style=for-the-badge&amp;logo=apple&amp;logoColor=white" alt="Download Academia on the App Store" />
  </a>
</p>

<p align="center">
  <a href="https://github.com/opencrafts-io/academia/actions/workflows/security.yml">
    <img src="https://github.com/opencrafts-io/academia/actions/workflows/security.yml/badge.svg?branch=staging" alt="Security and quality workflow" />
  </a>
  <a href="https://github.com/opencrafts-io/academia/actions/workflows/asset_consistency.yml">
    <img src="https://github.com/opencrafts-io/academia/actions/workflows/asset_consistency.yml/badge.svg?branch=staging" alt="Asset consistency workflow" />
  </a>
  <img src="https://img.shields.io/badge/Flutter-3.47.4-02569B?logo=flutter&amp;logoColor=white" alt="Flutter 3.47.4" />
  <img src="https://img.shields.io/badge/Dart-%5E3.13.2-0175C2?logo=dart&amp;logoColor=white" alt="Dart ^3.13.2" />
</p>

<p align="center">
  <a href="https://github.com/opencrafts-io/academia">
    <img src="https://img.shields.io/github/stars/opencrafts-io/academia?style=for-the-badge&amp;logo=github&amp;label=Star%20on%20GitHub" alt="Star Academia on GitHub" />
  </a>
  <img src="https://img.shields.io/badge/Proudly_made_in-Kenya-006600?style=for-the-badge" alt="Proudly made in Kenya" />
</p>

<p align="center">
  <a href="#everything-for-campus-life">What is inside</a>
  <span> | </span>
  <a href="#contribute-to-academia">Contribute</a>
  <span> | </span>
  <a href="#quick-start">Quick start</a>
  <span> | </span>
  <a href="CONTRIBUTING.md">Contributor guide</a>
  <span> | </span>
  <a href="https://github.com/opencrafts-io/academia/issues/new/choose">Report an issue</a>
  <span> | </span>
  <a href="https://github.com/opencrafts-io/academia/pulls">Pull requests</a>
</p>

## Why Academia

Academic work, campus systems, events, communities, and personal focus often
live in separate tools. Academia brings the parts of student life that belong
together into one app.

It is a Flutter application for planning academic work, accessing institution
information, studying with intention, participating in campus life, and keeping
track of what matters.

## Everything for campus life

| Moment | Academia helps you |
| --- | --- |
| Start the day | Check schedules, course information, institutional portal access, and what is next. |
| Stay on top | Organize todos, agenda items, timetables, exams, and important deadlines. |
| Study smarter | Use a Pomodoro timer, GPA calculator, and AI features that support your academic workflow. |
| Find your people | Join Chirp communities, share posts, and take part in campus conversations. |
| Show up | Discover, organize, ticket, and check in to Sherehe events. |
| Protect your focus | Use Lock In, app blocking, streaks, and progress tools to make time count. |
| Make it yours | Link an institution, manage your profile, and control notification preferences. |

## Built in Kenya, open to every campus

Academia is proudly made in Kenya and shaped by the everyday realities of
campus life. The project welcomes contributors, student communities, designers,
and builders from around the world who want to make student life easier to
navigate.

Campuses have different systems, calendars, and communities. Contributions that
represent those local contexts help make Academia more useful everywhere.

## Contribute to Academia

Academia is open source and welcomes contributions from students, developers,
designers, and campus communities. You can improve a workflow, support a new
campus context, or help maintain the project by starting here:

- [Star the repository](https://github.com/opencrafts-io/academia) to help more
  contributors discover it.
- [Share a product idea](https://github.com/opencrafts-io/academia/issues/new?template=feature_request.md)
  from your campus.
- [Report a problem](https://github.com/opencrafts-io/academia/issues/new?template=bug_report.md)
  so the experience gets stronger.
- [Read the contribution guide](CONTRIBUTING.md) and build the next useful
  student workflow with us.

## Built with Flutter

Academia is built with Flutter and Dart. Product features live in `lib/`, while
reusable platform services live in `packages/`. This keeps student-facing work
close to its feature and keeps shared concerns, such as billing, notifications,
permissions, analytics, and persistence, behind clear package boundaries.

## Quick start

### Prerequisites

- Flutter `3.47.4`, matching the GitHub workflows.
- A Dart SDK compatible with `^3.13.2`.
- Android Studio or Xcode when targeting a mobile simulator or device.

### Get the app running

```bash
git clone https://github.com/opencrafts-io/academia.git
cd academia
flutter pub get
flutter run --flavor development --target lib/main_development.dart
```

The entry point selects the environment. Use the target that matches the
environment you intend to run:

| Environment | Entry point | Android flavor |
| --- | --- | --- |
| Development | `lib/main_development.dart` | `development` |
| Staging | `lib/main_staging.dart` | `staging` |
| Production | `lib/main_production.dart` | `production` |

For example, run staging with:

```bash
flutter run --flavor staging --target lib/main_staging.dart
```

Build a production Android App Bundle with:

```bash
flutter build appbundle --release --flavor production \
  --target lib/main_production.dart
```

## Repository guide

```text
lib/
  config/        application configuration, guards, and typed routes
  core/          host composition and cross-cutting integrations
  features/      student-facing product areas
  main_*.dart    development, staging, and production entry points
packages/
  core/          shared networking, failures, and configuration
  database/      Drift persistence and migrations
  analytics/     typed product events and feature-flag access
  billing/       plans, subscriptions, checkout, and paywall UI
  notifications/ push and local notification delivery
  permissions/   runtime-permission policy and UI
  in_app_update/ remote update-policy evaluation
  lock-in/       focus-app blocking orchestration
  ads/           advertising integration boundary
assets/          images, illustrations, fonts, and generated asset inputs
```

### Package documentation

| Package | Responsibility |
| --- | --- |
| [`analytics`](packages/analytics/README.md) | Typed analytics events, PostHog integration, and feature flags. |
| [`app-blocker`](packages/app-blocker/README.md) | Cross-platform app blocking, schedules, and focus profiles. |
| [`billing`](packages/billing/README.md) | Plans, subscriptions, checkout handoff, and paywall UI. |
| [`database`](packages/database/README.md) | Drift-backed persistence, schema ownership, and migrations. |
| [`in_app_update`](packages/in_app_update/README.md) | Remote optional and required update campaigns. |
| [`notifications`](packages/notifications/README.md) | Push and local notification delivery. |
| [`permissions`](packages/permissions/README.md) | Runtime-permission policy and notification permission UI. |

## Development workflow

### Generated code and assets

This project uses generated code for assets, routes, serializers, database
artifacts, and dependency configuration. Do not edit generated files by hand.
After changing an asset declaration or another generation input, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

The [asset consistency workflow](.github/workflows/asset_consistency.yml)
regenerates outputs on pull requests and fails when generated files are missing
from the change.

### Quality checks

Before opening a pull request, format, analyze, and test the code relevant to
your change:

```bash
dart format .
flutter analyze
flutter test
```

The [security and quality workflow](.github/workflows/security.yml) runs static
analysis and a filesystem vulnerability scan for pull requests to `main` and
`staging`.

## Contributing

Contributions are welcome, whether you are improving a campus workflow,
strengthening a shared package, refining an interface, or fixing a defect.
Read [CONTRIBUTING.md](CONTRIBUTING.md) for setup, branches, generated assets,
commit conventions, and pull-request expectations.

Useful links:

- [Open a bug report](https://github.com/opencrafts-io/academia/issues/new?template=bug_report.md)
- [Request a feature](https://github.com/opencrafts-io/academia/issues/new?template=feature_request.md)
- [Browse open issues](https://github.com/opencrafts-io/academia/issues)
- [Review pull requests](https://github.com/opencrafts-io/academia/pulls)
- [View Actions runs](https://github.com/opencrafts-io/academia/actions)

## Project links

- Repository: <https://github.com/opencrafts-io/academia>
- Android package ID: `io.opencrafts.academia`
- Current version: `3.5.1+50`
