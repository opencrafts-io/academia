# Contributing to Academia

Thank you for helping make Academia more useful for students. Contributions can
improve a product workflow, a shared package, documentation, assets, tests, or
the developer experience.

## Before you start

1. Search [open issues](https://github.com/opencrafts-io/academia/issues) and
   [pull requests](https://github.com/opencrafts-io/academia/pulls) to avoid
   duplicating work.
2. For a bug, use the [bug report template](https://github.com/opencrafts-io/academia/issues/new?template=bug_report.md).
3. For an idea or a broader product change, use the [feature request template](https://github.com/opencrafts-io/academia/issues/new?template=feature_request.md)
   before investing in a large implementation.
4. Keep security-sensitive details, credentials, and personally identifiable
   information out of issues, commits, and pull requests.

## Set up your environment

The GitHub workflows use Flutter `3.47.4`; use that version locally whenever
possible. The project requires Dart `^3.13.2`.

```bash
git clone https://github.com/opencrafts-io/academia.git
cd academia
flutter pub get
flutter run --flavor development --target lib/main_development.dart
```

Use the appropriate entry point for staging or production work:

| Environment | Command target |
| --- | --- |
| Development | `lib/main_development.dart` |
| Staging | `lib/main_staging.dart` |
| Production | `lib/main_production.dart` |

## Create a focused branch

Branch from `staging` unless a maintainer asks you to target another branch.
Choose a name that makes the intent clear:

```text
feat/exam-reminder
fix/timetable-empty-state
docs/improve-onboarding
chore/refresh-generated-assets
```

Keep a branch focused on one coherent outcome. Separate refactors, feature
work, and unrelated formatting so reviews and reversions stay straightforward.

## Make the change

### Respect package boundaries

- Keep student-facing product work in the relevant `lib/features/` area.
- Put reusable platform concerns in the package that owns them.
- Use typed interfaces from `analytics`, `permissions`, `notifications`, and
  `billing` instead of importing their vendor SDKs into feature code.
- Put new persistence tables and migrations in `packages/database`; do not add
  new tables to the legacy database.

### Generated files and assets

When changing an asset declaration, route annotation, serialization model,
Drift schema, or injectable configuration, regenerate code and include the
resulting tracked files in the pull request:

```bash
dart run build_runner build --delete-conflicting-outputs
```

The [asset consistency workflow](.github/workflows/asset_consistency.yml)
checks this for pull requests to `main`, `staging`, and `platform/apple`.

For visual changes, include screenshots or a short recording in the pull
request. Store source assets in `assets/` and update `pubspec.yaml` before
regenerating the asset outputs.

## Check your work

Run the checks that cover your change before requesting review:

```bash
dart format .
flutter analyze
flutter test
```

Run a more focused package test command when only one package changes. The
[security and quality workflow](.github/workflows/security.yml) also runs
analysis and a filesystem vulnerability scan for pull requests to `main` and
`staging`.

## Commit clearly

Use [Conventional Commits](https://www.conventionalcommits.org/). Keep the
summary imperative, specific, and in English:

```text
feat(timetable): add course filter
fix(auth): handle expired callback state
docs(readme): clarify flavor commands
```

Do not add secrets, tokens, personal data, or generated changes that are
unrelated to your work.

## Open a pull request

Target `staging` unless a maintainer has asked for a different base branch.
Describe the problem, the approach, and the user-visible result. Link the
related issue and call out any changes to migrations, permissions, analytics,
native configuration, or generated files.

Before requesting review, confirm that your pull request:

- Has a concise title and focused scope.
- Includes screenshots for visible UI changes.
- Includes regeneration output when applicable.
- Explains any change to platform permissions or external integrations.
- Has no credentials or personal data in code, logs, screenshots, or commits.

Maintainers may request a smaller scope, a follow-up issue, or clarification
when a change affects a shared package or a student-facing workflow.
