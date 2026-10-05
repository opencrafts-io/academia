# Internal school portal sync

**Status: INCOMPLETE AND HIGHLY UNSTABLE.** This Git checkpoint preserves work in
progress for internal testing; it is not a production-ready universal portal sync.
Real school sync on a device remains unverified, and the remaining work below is
still required. Debug subscription bypass and increased local usage limits remain
enabled for testing.

This first slice observes a student-selected HTTPS portal while the student browses,
maps HTML tables through Firebase AI Logic, extracts rows locally, and shows a review
before saving courses and simple weekly meetings. There is no school recipe service.
Professor continues to receive ordinary records through the shipped course repository.

## Package boundaries

- `packages/magnet`: read-only browser observation, origin checks, bounded snapshots,
  form/authentication exclusions, SPA navigation, pause/resume, and local highlighting.
  Existing command execution APIs remain available for the shipped legacy flow.
- `packages/portal_sync`: domain snapshots and extraction plans, local extraction,
  provider interface, Firebase adapter, cache/usage stores, session controller, and
  Material 3 portal/review UI. The provider receives structural labels, table headers,
  and coarse cell types, not table rows, screenshots, passwords, or cookies.
- `lib/core/integration/portal_sync`: app composition, subscription gate, private replay
  lifecycle, Firebase bootstrap, and the adapter to `packages/courses`.

The import ledger stores account/origin-scoped hashes and local record IDs. Repeated
imports update linked records only while their managed fields still match the last
import baseline. Manual edits, ambiguous identities, and user-deleted records are
kept. Records absent from a portal capture are never deleted. A failed batch can be
retried; each successful write is linked before the next write begins. Writes already
in flight use the existing repository's lifecycle; later writes stop if the account
changes.

The entire portal route is masked, and PostHog replay is suspended before creating the
native browser. Replay restoration waits for startup/route teardown, including closing
the screen during initialization. The browser uses an ephemeral session; a student
signs in again after closing it. No captured data is deliberately sent to analytics.

## Configure a closed tester build

The feature is enabled by default in debug builds and disabled by default in profile
and release builds. Use `PORTAL_SYNC_ENABLED=true` to enable a closed tester release,
or `PORTAL_SYNC_ENABLED=false` to disable it in any build. Firebase configuration is
saved in `lib/firebase_options.dart` for project `academia-28cec`. Android selects
the development, staging, or production registration using its installed package
name; iOS uses `io.opencrafts.academia`. No Firebase environment values are required.
Existing app startup does not depend on portal Firebase initialization.

1. Use the configured Firebase project `academia-28cec` and its existing Academia
   Android and iOS registrations.
2. Enable Firebase AI Logic with the Gemini Developer API provider. Configure App
   Check and enforce it for AI Logic. Android uses Play Integrity; Apple uses App
   Attest with DeviceCheck fallback. Debug builds automatically use the Android and
   Apple debug providers. On the first analysis attempt, copy the debug token printed
   by the native Firebase SDK and register it under Firebase console → App Check →
   the matching Academia app → Manage debug tokens. Keep that token private; do not
   include it in an error report. Set `PORTAL_APP_CHECK_DEBUG=false` to test device
   attestation in debug mode. Release builds reject debug providers.
3. Apply low project quotas and the available spend controls in the Firebase console.
   Alerting alone does not stop spending, and spend-cap enforcement can be delayed.
   Keep distribution to trusted testers until server entitlement/budget enforcement
   is added. Local counters and UI gating can be bypassed.
4. Debug builds temporarily bypass the portal subscription lookup for testing.
   Restore it with `--dart-define=PORTAL_BYPASS_SUBSCRIPTION=false`.
   Profile and release builds always require an active Academia subscription.
   Account checks and usage limits remain active during the debug bypass.
5. Run the development entry point normally:

```sh
flutter run --flavor development -t lib/main_development.dart
```

For a closed tester release add `--dart-define=PORTAL_SYNC_ENABLED=true`.
Optionally override `PORTAL_AI_MODEL` (default `gemini-3.8-flash`) with a model
enabled in your project. Firebase AI Logic enablement and App Check attestation
still require verification in the Firebase console and on a device.

Gemini requests omit explicit sampling parameters (`temperature`, `topP`, `topK`,
`candidateCount`) to follow the current model API contract. The JSON response
schema and 1000 output-token cap remain enabled. See the
[Gemini 3.8 migration guide](https://ai.google.dev/gemini-api/docs/generate-content/latest-model).

The response schema uses required nullable column fields and omits numeric bounds,
array-size constraints and enum format hints from the provider request. The parser
still enforces indices 0–63, at most 32 table mappings and known snapshot nodes.
A synthetic live Firebase request reproduced HTTP 400 with the original schema;
the compact schema returned HTTP 200 and valid JSON using `gemini-3.5-flash-lite`.
The October 4 pass observed the project's `gemini-3.8-flash` free-tier daily request
quota exhausted (provider reported 20/day); that pass did not verify live 3.8 behavior.
For testing while that quota resets, override the model with
`--dart-define=PORTAL_AI_MODEL=gemini-3.5-flash-lite`. Local attempt allowances
cannot increase provider quotas.

In Academia open **Essentials → School portal sync**. With one linked school it opens
directly; with several it asks which school to use; with none it opens school linking.
The school dashboard also has a **Connect your school portal** shortcut. Enter the
portal address and start sync. Sign in directly, then navigate to courses/timetable.
Expand the assistant to review the detected records. Class times are school-local
wall-clock times and weekly; they are not converted to the phone's timezone. Check
your resulting course timetable after saving, especially any records reported as kept.

## Cost controls

Debug builds write local Flutter console diagnostics prefixed `[portal_sync]`.
After restarting, reproduce the failure and copy the `analysis.failed` line and
following stack frames. The logs identify the model, Firebase registration,
failure stage and sanitized SDK error. Snapshot values, account identifiers,
prompts and model response bodies are omitted. Diagnostics are disabled in profile
and release builds. Close and reopen the portal to start a new capture if its
bounded retry has already been used; usage limits still apply.

Validated page mappings are scoped by account, origin, language, structure, model,
prompt, and schema version. Fresh rows reuse a cached mapping. One inference is in
flight per controller; observations coalesce, calls have a timeout, and failures do
not automatically retry. The student can request one retry for an unchanged structure.
Profile/release limits allow six setup attempts daily until the first save, then
four daily, with thirty monthly attempts. Academia debug builds temporarily allow
fifty attempts daily and one hundred monthly while testing Firebase setup. These
allowances do not change Firebase/provider quotas. Failed calls also consume
attempts. Local limit blocks log `[portal_sync] usage.local_limit_reached`;
provider failures log `analysis.failed` with the SDK error type. Pausing or changing
connection invalidates stale results. Raw snapshots and drafts are memory-only.

## Validation recovery and diagnostics

The assistant retains independently validated course and meeting mappings when an
AI response contains an invented hint, an unrelated table or a duplicate mapping.
One table can provide both courses and weekly meetings. Unknown node references,
out-of-range columns, unsupported schedules and identity/payment data remain
excluded. Only validated mappings enter the cache. Prompt version 2 invalidates
older mappings after the stricter mapping instructions change.

An empty `other` mapping on a fee/profile page is normal browsing, not an analysis
failure. Summary and malformed table rows are skipped locally. The browser combines
multirow headers, ignores title/footer/summary rows and skips ambiguous layouts
instead of shifting column positions.
An explicit academic table can be read inside a profile dashboard; the dashboard
title alone no longer discards it. Generic fee/profile tables still fail validation,
and exam/assessment pages remain excluded from weekly class schedules.

Debug logs now identify the validation rule, for example
`analysis.validation_failed reason=column_out_of_bounds table=0 column=9 headers=2`.
Recovered responses log `analysis.mapping_adjusted` with retained/dropped counts;
invalid table candidates log `analysis.table_rejected`. These diagnostics contain
codes, types, indices and counts, never portal labels, node IDs or row values.
Close and reopen the portal after restarting to clear a failed capture's retry state.

Capture-limit notices concern table rows omitted by the row, table-count or local
payload limits. Bounded navigation menus, skipped layout tables and privacy
exclusions do not raise this notice. A subsequent complete capture clears it.
The notice does not block review or save: use the portal's filters or pagination
to capture remaining rows. Debug logs report `capture.partial` and, when a prior
notice clears, `capture.complete`; no portal content is logged.

The local integration fixture exercises browser sanitization, Firebase's actual
request/response serializer, mapping recovery, review, save and a cached timetable
update through the Academia importer. Its model transport is a local fixture:
it makes no cloud request and does not establish compatibility with a real portal.

## Coverage and remaining work

This is a table-based internal slice, not proven compatibility with every school.
Observation is bounded and operates while the student browses; it does not sign in
or click for them. Cross-origin SSO may navigate, but capture stays limited to the
explicitly connected origin. Some identity providers refuse embedded browsers.

Profile and fees extraction, date/term bounds, source timezone storage, richer
recurrence, calendar/document imports, screenshot fallback, reconnect persistence,
the remaining institution-package migration, and trusted Firebase subscription/budget
enforcement remain phases in [the full plan](portal-sync-plan.md). Ambiguous or unsupported
patterns are skipped instead of guessed. Live Gemini/project/App Check configuration
and real school login sessions require validation on a configured device.

## Verification

Run from the repository root after `flutter pub get`:

```sh
flutter test packages/portal_sync/test packages/magnet/test test/core/integration/portal_sync
flutter analyze packages/portal_sync/lib packages/magnet/lib/src/observer lib/core/integration/portal_sync
```

Verified on 2026-10-05:

- Portal package: 39 tests passed. App portal integration: 23 tests passed,
  including the real Firebase SDK serializer with a local model transport,
  mapping recovery, review, save and a cached timetable update.
- Scoped analyzer across both packages, app portal integration and Firebase
  options: no issues found. `git diff --check` passed.
- Firefox capture fixture passed with grouped/multirow headers, summary/footer
  exclusions and malformed-row handling alongside the existing browser cases.

Earlier checks on 2026-10-04:

- Combined portal package and app integration suite: 45 tests passed.
- Essentials entry-point follow-up: four navigation tests passed; the complete app
  adapter/privacy/entry suite passed 16 tests.
- Scoped analyzer across the new packages, app adapter, and modified routes/home UI:
  no issues found. `git diff --check` passed.
- Firefox 157 fixture executing the injected JavaScript: passed visible/hidden/auth
  exclusions, table prioritization, capture limits, SPA/full navigation, and stable
  node IDs over twenty repeated captures. Run with
  `node --test packages/magnet/test/dom/portal_observer_firefox_test.mjs` using local
  Firefox and loopback access.
- Readable UI previews inspected at 390×844, including 1.7× text and course/timetable
  review. Large-text setup scrolls to the form and action.
- Existing course tests: 12 passed; existing flavor injection test: passed. The
  separate `test/core/package_dependency_injection_test.dart` failed because its
  fixture omits `Dio` before the Todos dependencies are instantiated. Those DI/Todos
  sources were unchanged; normal app startup registers `Dio` first.

Application builds are left to the developer as requested. The synthetic live
Firebase probe described above does not establish a successful real school sync.
No successful packaged build or authenticated school sync on a device is claimed.
No backend migration or deployment is required for this slice.
