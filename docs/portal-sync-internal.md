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

A second, equally unstable slice adds the `profile` and `fee_statement` page
categories on top of the same capture/analysis/cache machinery, and a new
`packages/institutions` package to hold the evidenced profile/fee domain model and
its local repositories. See "Profile and fees (phase 2 slice)" below for what this
covers and what remains open; it has not been exercised against a real school portal
or a live Firebase call any more than the courses/timetable slice has.

## Package boundaries

- `packages/magnet`: read-only browser observation, origin checks, bounded snapshots,
  form/authentication exclusions, SPA navigation, pause/resume, and local highlighting.
  Existing command execution APIs remain available for the shipped legacy flow.
- `packages/portal_sync`: domain snapshots and extraction plans, local extraction,
  provider interface, Firebase adapter, cache/usage stores, session controller, and
  Material 3 portal/review UI. The provider receives structural labels, table headers,
  and coarse cell types, not table rows, screenshots, passwords, or cookies. Now also
  carries the `profile`/`fee_statement` page categories: field mappings for labelled
  profile values, a `feeLineItems` table kind with date/description/debit/credit/
  balance/currency columns, a `PortalProfileFeeDraftExtractor`, and a smaller,
  parallel `PortalProfileFeeController`/`PortalProfileFeeReview` capture/review path
  that does not share state with the courses/timetable controller.
- `packages/institutions` (new): `AcademicProfileEntity`/`FeeStatementEntity` with
  field-level evidence (source page, observation time, source account, original
  value, normalized value, validation outcome), `SharedPreferences`-backed
  repositories, and a minimal read-only `InstitutionRecordsCubit` + summary widgets
  for already-saved records. Depends on `package:core` only; does not import
  `package:academia/...` or any non-exported `portal_sync` file. `MonetaryAmount`
  never defaults an unconfirmed currency to KES or an unparsable amount to zero;
  both stay `null`/`rejected` until a confirmed value is observed.
- `lib/core/integration/portal_sync`: app composition, subscription gate, private replay
  lifecycle, Firebase bootstrap, the adapter to `packages/courses`
  (`AcademiaPortalImporter`), and the adapter to `packages/institutions`
  (`AcademiaInstitutionPortalImporter`).

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

## Profile and fees (phase 2 slice)

**This path cannot currently produce a draft from a real portal.** Everything
below — parser, extractor, controller, review UI, importer — is implemented and
unit-tested, but `FirebasePortalAnalysisClient`'s *request* schema was never
extended to match: it still constrains `pageType` to `courses`/`timetable`/`other`
and table `kind` to `courses`/`meetings`, never mentions `fields` or
`feeLineItems`, and its system instruction still says "Never map exams, payments
or student identity fields." The model therefore cannot return a `profile` or
`feeStatement` plan. The tests pass because they construct `PortalAnalysisPlan`
objects from JSON directly, bypassing the schema. Extending that schema and
instruction is the first thing this slice needs; see "Known defects found in
review" below.

A first slice of phase 2 ("Expand coverage and supported data" in
[the full plan](portal-sync-plan.md)) adds the `profile` and `fee_statement` page
categories. It reuses the same snapshot/plan/cache machinery as courses/timetable
rather than duplicating it:

- `PortalAnalysisPlan` gained `PortalPageType.profile`/`feeStatement`, a
  `PortalTableKind.feeLineItems` table kind with `date`/`description`/`debit`/
  `credit`/`balance`/`currency` columns, and a `fields` list mapping labelled
  `field` snapshot nodes to a fixed `PortalProfileFieldKey` enum (name, registration
  number, programme, faculty, year of study, enrollment status, institution email,
  phone number -- deliberately excluding national ID and disability fields, which
  the schema cannot reference at all). Schema/prompt versions were bumped
  (`schemaVersion` 2, `promptVersion` "portal-structure-v3") so stale cached plans
  are revalidated rather than reinterpreted under the new, stricter contract.
- A fee table must look like one on its own terms: it needs a description column
  and at least one of debit/credit/balance, and its own label/headers must match
  fee vocabulary (fee, tuition, invoice, statement, debit, credit, balance, payment,
  receipt). A page merely titled "fees" does not make a generic two-column table
  validate, and an empty mapping on a fee/profile page still validates as normal
  browsing, matching the existing "generic fee/profile tables still fail
  validation" / "empty `other` mapping is normal browsing" rules.
- `PortalProfileFeeDraftExtractor` extracts validated field values and fee rows
  into `PortalProfileFieldDraft`/`PortalFeeLineItemDraft`, distinguishing debit,
  credit, running balance and balance-due rows (a "Balance" column's row is
  `balanceDue` only when its own description says so, e.g. "balance due"/"total
  due"/"amount due"/"outstanding"; otherwise it is a plain running balance).
  Currency is read only from a mapped currency column and is `null` when absent --
  never guessed or defaulted.
- `packages/institutions` holds the evidenced domain model
  (`AcademicProfileEntity`, `FeeStatementEntity`, `FieldEvidence`,
  `MonetaryAmount`) and `SharedPreferences`-backed repositories that merge by
  stable identity (never duplicate-create, never delete on absence from a partial
  capture).
- `PortalProfileFeeController` (in `packages/portal_sync`) runs its own smaller
  capture -> cache/analyze -> validate -> extract -> review -> save loop, and
  `AcademiaInstitutionPortalImporter` (in `lib/core/integration/portal_sync`)
  adapts its drafts into `packages/institutions` entities with full evidence,
  using the same ledger/baseline-hash pattern as `AcademiaPortalImporter` to skip
  writing a field/line whose stored value has diverged from the last import
  baseline (preserving a manual edit) and to never delete a line absent from a
  later partial capture.

Open items for this slice, not yet done:

- **Not wired into the app.** `PortalProfileFeeController`, its review widget, and
  `AcademiaInstitutionPortalImporter` are not registered at any composition root
  and are not reachable from the existing portal-sync screen or navigation. The
  manual `registerInstitutionsDependencies(GetIt)` helper in
  `packages/institutions` is never called from `lib/`. This slice is exercised only
  by its own package/integration tests, not by the shipped UI.
- **No term grouping for fee statements.** Extracted fee lines are not yet
  associated with a term/semester (no `term` column was added to the fee column
  map); the importer writes every observed fee line into one statement per
  account/institution. `FeeStatementEntity.term` exists in the domain model but is
  always `"current"` end to end today.
- **No date normalization.** `FeeLineItemEntity.rawDate` is preserved as captured;
  `normalizedDate` is never populated by the extractor/importer in this slice.
- **`PortalProfileFeeController` has no pause/resume, retry backoff, or the
  row-group merge-on-same-path logic** that `PortalSyncController` has for
  paginated courses/timetable tables; a recaptured page simply replaces its prior
  snapshot wholesale.
- **No live Firebase/Gemini call, and no real portal/device verification**, exactly
  as for the courses/timetable slice -- see the existing caveats on the
  synthetic/local-fixture-only integration test below, which now also covers the
  profile/fee importer.
- `packages/institutions`' own presentation layer is read-only (shows already-saved
  records); it has no edit/review screen of its own, since the review step for
  newly captured data stays in `packages/portal_sync`'s `PortalProfileFeeReview`.

## Calendar subscriptions and the document/image fallback (Phase 2, partial)

Two additive import paths now exist alongside the live-DOM capture above. Both
are implemented and unit-tested; neither has been exercised against a real
school feed, a real Gemini multimodal call, or a device picker/camera UI.
Treat them with the same "incomplete and highly unstable" caution as the rest
of this checkpoint.

**Calendar feed (.ics) import** — `packages/portal_sync/lib/src/data/datasources/ics_calendar_parser.dart`
and `ics_feed_fetcher.dart`, `lib/src/domain/entities/ics_calendar_event.dart`,
`ics_feed_url_policy.dart`, `portal_calendar_draft.dart`, and
`lib/src/presentation/portal_calendar_feed_controller.dart`:

- `DioIcsFeedFetcher` fetches a student-pasted feed URL under hard guardrails:
  HTTPS-only scheme allowlist, a loopback/private/link-local host blocklist
  (string-level, not DNS-resolved), a 2&nbsp;MB response ceiling enforced while
  streaming (never fully buffered first), a 20s timeout, and redirects that
  are never auto-followed by the HTTP client — only by an explicit loop that
  re-validates the full URL policy on every hop. The feed URL is never logged;
  failures surface only a stable reason code.
- `IcsCalendarParser` implements the RFC 5545 subset directly rather than
  adding a pub.dev ICS dependency: line unfolding, `VEVENT`
  UID/SUMMARY/DESCRIPTION/LOCATION, `DTSTART`/`DTEND` with `VALUE=DATE`, the
  UTC `Z` suffix, or a `TZID` parameter, `RRULE` (`FREQ`/`INTERVAL`/`COUNT`/
  `UNTIL`/`BYDAY`, preserved structurally rather than expanded into
  occurrences), `EXDATE` exceptions, and a representative `VTIMEZONE` offset.
  This mirrors the hand-rolled, defensively-bounded parsing style already used
  for `PortalSnapshot`/`PortalAnalysisPlan` on other untrusted input, and
  avoids pulling an unvetted third-party parser onto an attacker-reachable
  path (a pasted feed URL) for a small, precisely-bounded subset of the spec.
- A timed event with no `TZID` and no `Z` suffix is never assumed to be the
  phone's timezone: `IcsDateTime.hasMissingTimeZone` forces it into the
  ambiguous/needs-review bucket instead.
- Classification (`IcsCalendarEvent.shape`) buckets events into
  `classMeeting` (weekly `RRULE`, positive duration), `deadline` (no `RRULE`,
  all-day or zero/undefined duration), or `ambiguous`/needs-review for
  everything else, including any missing-timezone event. Class-meeting-shaped
  events are **never auto-imported**, even into the generic agenda calendar:
  there is no reliable course identity in an arbitrary feed to attach a
  meeting to, and writing a loose calendar entry would blur the line this doc
  asks Academia to keep between class meetings and non-class events. Only
  `deadlines` import automatically, through `AcademiaPortalCalendarImporter`
  (`lib/core/integration/portal_sync/academia_portal_calendar_importer.dart`)
  into the existing `todos` package (`GetDefaultTodoListUsecase` +
  `CreateTodoItem`), with a reused import-ledger keyed by feed+event identity
  to avoid duplicate tasks on repeat import — checked against only the first
  page of the target list, so a very large existing list could rarely still
  duplicate one.
- Not implemented: expanding `RRULE`/`EXDATE` into concrete occurrences (kept
  as structured data only), full historical `VTIMEZONE` DST transition rules
  (only a single representative offset is kept), and any UI for connecting a
  feed URL or reviewing/linking class-meeting-shaped events to a course —
  `PortalCalendarFeedController` and the classification/import engine exist
  and are tested, but nothing in `portal_sync_page.dart` surfaces them yet.

**Document/image fallback** — `lib/src/domain/entities/portal_media_selection.dart`,
`portal_media_extraction_plan.dart`, `portal_media_analysis_request.dart`,
the `analyzeMedia` extension to `FirebasePortalAnalysisClient`, and
`PortalSyncController.analyzeMediaFallback`:

- Student-initiated only: a new `PortalMediaFallbackPrompt` widget shows the
  data-leaves-the-device disclosure copy and requires an explicit "Continue"
  tap before any picker opens; nothing captures automatically.
- `PortalMediaSelection.validated` enforces ceilings distinct from the
  8,000-input/1,000-output token text bounds: 6&nbsp;MB for an image, 15&nbsp;MB
  for a document, and (PNG only, via a pure header read, no decode) a
  6000px-per-side pixel ceiling. JPEG/WEBP/PDF pixel/page ceilings are not
  implemented — only the byte ceiling applies to them; this is a known gap,
  not a silently-assumed-safe one.
- `FirebasePortalAnalysisClient.analyzeMedia` extends the existing adapter
  (shared model-construction helper, same `maxOutputTokens`/JSON schema
  discipline) rather than forking a second client, sending
  `Content.multi([TextPart(...), InlineDataPart(mimeType, bytes)])` and a
  value-returning schema (`PortalMediaExtractionPlan`): unlike the DOM path's
  column-index plan, there is no local table to re-read, so the model must
  return field values directly, bounded and validated exactly as strictly as
  the DOM path's column indices are.
- `PortalSyncController.analyzeMediaFallback` spends from the **same**
  `PortalUsageStore` allowance as the DOM path (same account key, same
  check-then-record-before-the-provider-call sequence, so a failed media call
  still consumes an attempt) — it does not bypass or duplicate the budget.
  A successful extraction converts to a `PortalDraft` using the same stable
  source-identity hashing as the DOM extractor, so the same course observed
  through either path upserts instead of duplicating, and lands in the same
  `PortalSyncState.review`/`saveDraft()`/`PortalImporter` pipeline the DOM
  path uses. On a source-id collision the on-device DOM value is kept over
  the model-read image value.
- Not implemented: the actual on-screen region-crop UI (the picker adapter
  offers gallery image and document picking via the app's existing
  `image_picker`/`file_picker` dependencies, not a crop tool), and wiring
  `PortalMediaFallbackPrompt`/`AcademiaPortalMediaPicker` into
  `portal_sync_page.dart`'s live screen.

## Coverage and remaining work

This is a table-based internal slice, not proven compatibility with every school.
Observation is bounded and operates while the student browses; it does not sign in
or click for them. Cross-origin SSO may navigate, but capture stays limited to the
explicitly connected origin. Some identity providers refuse embedded browsers.

Term/date bounds for fee statements, source timezone storage, richer recurrence,
reconnect persistence, the remaining institution-package migration, and trusted
Firebase subscription/budget enforcement remain phases in
[the full plan](portal-sync-plan.md).

The profile/fee slice, the calendar feed import and the document/image fallback
all now have tested engines (see the sections above), but **none of the three is
wired into the shipped UI**: no live-screen entry point exists for reviewing
captured profile/fee records, pasting a feed URL, or triggering the media
fallback, and the profile/fee slice is not registered at the app composition
root. They are exercised only by their own tests.

Passing tests should not be read as working features here. A 2026-10-10 review
found eleven defects across these slices, including one that makes the profile/fee
path unreachable from a real portal and four that lose or corrupt data; the unit
tests pass over all of them because they exercise the layers below the provider
request. See "Known defects found in review" below before building on any of this.

Ambiguous or unsupported patterns are skipped instead of guessed. Live Gemini/
project/App Check configuration and real school login sessions require
validation on a configured device.

## Phase 4 cleanup: Academia client only

Done 2026-10-06. This covers **only the Academia (Flutter client) half** of Phase
4's "obsolete Daystar/teaching/recipe integration cleanup." The Professor-backend
half (its legacy command model, recipe/teaching endpoints) is untouched: that
checkout lives on a separate machine this branch's checkouts cannot reach, and
removing dead client code here does not retire any backend endpoint, drop a
migration, or touch production data.

The plan's findings table named `daystar_portal_models.dart` and
`daystar_portal_actions_impl.dart` as evidence; neither file exists under those
names in this checkout. By the time of this cleanup the old flow had already been
renamed/restructured into a "scrapping command" model
(`lib/features/institution/data/dtos/institution_scrapping_command_api_dto.dart`,
`.../presentation/bloc/scrapping_command_bloc.dart`,
`.../presentation/bloc/magnet_bloc.dart` driving `packages/magnet`'s
command-execution API directly) — functionally the same obsolete flow the plan
describes, just under different file names.

Confirmed before deleting anything: `lib/core/integration/portal_sync/school_portal_page.dart`
and `school_portal_entry_card.dart` are already wired into navigation
(`SchoolPortalRoute` under `/institution/:id/portal` in `lib/config/router/routes.dart`,
and the "School portal sync" entry card on the Essentials page) and are the only
path a student reaches when `portalSyncEnabled` is on (debug builds by default).
Every app-level `package:magnet/magnet.dart` import outside `lib/core/integration/portal_sync/`
was confined to the old flow's files — nothing else in `lib/` used Magnet's
command-execution surface, confirming it was safe to stop calling from the app
layer. The old flow's recipe/command endpoint
(`/professor/api/magnet/command/for/:id`) was also already noted in the plan's
findings table as unexposed by the inspected Professor checkout, so the deleted
code could never have round-tripped successfully against that backend anyway.

Deleted (old command-execution flow, its datasource, and the mappers that only
served it):

- `lib/features/institution/presentation/bloc/{magnet,scrapping_command}_*.dart`
  (and generated `.freezed.dart`) — the institution-local `MagnetBloc` driving
  `packages/magnet`'s `Magnet.init`/`execute` command surface, and the
  `ScrappingCommandBloc` that fetched a published recipe to feed it.
- `lib/features/institution/data/datasources/institution_command_{local,remote}_datasource.dart`,
  `data/repository/institution_scrapping_command_repository_impl.dart`,
  `domain/repository/institution_command_repository.dart`,
  `domain/usecases/{fetch,get}_institution_scrapping_command_usecase.dart` — the
  recipe datasource/repository/usecases.
- `data/dtos/institution_scrapping_command_api_dto.dart`,
  `data/models/institution_scrapping_command_model_helper.dart` — the recipe DTO
  and its drift-row mapper (the `InstitutionScrappingCommands` **table and its
  migrations stay** in `lib/database/tables/institution_scrapping_commands.dart`;
  only the application-layer code reading/writing it was removed, per the "do not
  drop historical migrations" rule).
- `data/dtos/{magnet_course_dto,magnet_fee_statement_dto}.dart`,
  `data/mappers/magnet_course_import.dart` — redundant mappers that only parsed a
  raw Magnet scrape payload into courses/schedules/fees for `MagnetBloc`; the new
  flow's `AcademiaPortalImporter` (`lib/core/integration/portal_sync/academia_portal_importer.dart`,
  untouched) writes to `packages/courses`' `CourseRepository` directly with its
  own upsert/ledger logic and never used these.
- `SyncInstitutionProfileUsecase`/`SyncProfileParams` from
  `domain/usecases/student_profile_usecases.dart` — same shape, only caller was
  `MagnetBloc`.
- `presentation/views/{institution_keys_view,institution_not_supported_view}.dart`,
  `presentation/widgets/{institution_dashboard,institution_setup_sheet_content,sync_required_card,sync_status_section,magnet_loading_progress_card}.dart`
  — the manual-teaching/keys UI (filling in form fields for a recipe's
  instructions) and an already-dead prototype widget (`InstitutionDashboard` was
  defined but never instantiated anywhere).
- The `keys` sub-route (`InstitutionKeysViewRoute`) and its typed route, the
  `ScrappingCommandBloc`/`MagnetBloc` `BlocProvider`s in `InstitutionShellRouteData`,
  and all of the above's DI registrations in `lib/injection_container.dart`.
- The exam-timetable "is this institution supported" pre-check in
  `lib/features/essentials/presentation/essentials_page.dart` that called
  `FetchInstitutionScrappingCommandUsecase` before navigating — this was the one
  consumer of the recipe usecase outside `lib/features/institution`, and since the
  backend endpoint it hit is unexposed (so the check was already always-false in
  practice) and `ExamTimetableHomeScreen` already has its own empty state for an
  institution with no exam data, the pre-check was removed rather than kept alive
  for this single caller.

Kept, deliberately, though related:

- **`InstitutionKey` end to end** (entity, `InstitutionKeyRepository`/`Impl`,
  both local and secure datasources, `Get`/`SaveInstitutionKeyUsecase`,
  `InstitutionKeyBloc`) — not named in the plan's deletion list, and
  `InstitutionKeyRepositoryImpl`'s docstring says it lazily migrates any legacy
  plaintext key row into secure storage on first read. `InstitutionShellRouteData`
  still dispatches `GetInstitutionKeyEvent` on every institution-page visit
  (`lib/config/router/routes.dart`), so that migration keeps running
  automatically with no user-facing "keys" UI left to feed it. Only the UI entry
  points into it (the keys route/view, the app-bar key icon, the "Setup Required"
  sheet) were removed.
- Everything under `lib/database/` (table definitions, migrations, `database.g.dart`,
  `database.steps.dart`) — untouched, per the "removing dead code does not
  authorize dropping historical migrations or production data" rule.
- The Fees and Student-Profile features (`InstitutionFeesBloc`/repository/views,
  `StudentProfileBloc`/`CreateProfileUsecase`/etc.) — these are the still-needed,
  general-purpose profile/fee persistence that Phase 2 (profile/fees extraction
  via `portal_sync`) has not replaced yet; only the one scrape-specific sync path
  into them (`SyncInstitutionProfileUsecase`) was removed.
- `LinkInstitutionRequiredPage`/Route — unrelated to the old recipe flow; it gates
  exam-timetable access generally on "has any institution linked at all."

Verified 2026-10-06 (Flutter 3.47.4 via `fvm`, from the repo root after
`fvm flutter pub get` and `fvm dart run build_runner build`):

- `fvm flutter analyze lib test`: 68 issues, all pre-existing and unrelated
  (confirmed by re-running on the unmodified checkout via `git stash`) — mostly
  `unawaited_return_in_try_block` warnings in `chirp`/`leaderboard`/`streaks`
  datasources, plus `Gender`/`AcademicStatus`/`SyncStatus`/`TodoStatus`/`TodoPriority`
  `undefined_identifier` errors in committed `test/drift/academia/generated/schema_v*.dart`
  snapshots. Zero issues in anything this cleanup touched.
- `fvm flutter test test`: same three pre-existing failures as documented above
  under "Earlier checks," confirmed unrelated by re-running against the
  unmodified checkout: `test/core/analytics_boundary_test.dart` (an unrelated
  `AuthBloc` importing `posthog_flutter` directly), `test/core/package_dependency_injection_test.dart`
  (the documented Todos/`Dio` registration-order fixture issue), and
  `test/drift/academia/migration_test.dart` (fails to compile for the same
  pre-existing `schema_v*.dart` reason as above). No new failures.
- `fvm flutter test test/core/integration/portal_sync`: 23 passed.
- `fvm flutter test packages/portal_sync/test packages/magnet/test`: 48 passed
  (read-only verification only — neither package's `lib/` was modified).

Still open:

- The Professor-backend half of Phase 4 (its legacy command model, recipe/teaching
  endpoints) — not attempted from this checkout.
- The three pre-existing test/analyze failures above are unrelated to this
  cleanup and were left as found.
- `lib/database/tables/institution_scrapping_commands.dart` and its drift rows are
  now unused by any Dart application code but remain on disk/in the schema,
  as instructed.

## Phase 3: Flutter-side seam scaffolding (not enforcement)

**Status: NOT A PHASE 3 ACCEPTANCE GATE PASS.** This 2026-10-06 pass added
client-side scaffolding so a real server enforcement layer can be plugged in
later as a small, isolated swap. It does not implement, simulate, or verify
server enforcement. Read this section before touching any of the files it
names.

Hard boundary this pass worked under: this repository has no Firebase Cloud
Functions source (only a client-side `firebase.json` with FlutterFire app
registration, no `functions/` directory) and no access to the "Professor"
backend repository the plan references (it lives on a different machine).
No code in this pass pretends otherwise — nothing here fabricates a Cloud
Function, a token-minting endpoint, or any server-side check.

What changed, concretely:

- `packages/portal_sync/lib/src/domain/repositories/portal_sync_repositories.dart`
  now declares `PortalInferenceGateway`, replacing the narrower
  `PortalAnalysisClient`. Its `analyze` returns a `PortalInferenceOutcome` —
  either `PortalInferenceSuccess(plan)` or a typed, non-exceptional
  `PortalInferenceRejected(reason, message)` with reason
  `noEntitlement` or `allowanceExhausted`. A technical failure (network,
  timeout, malformed output) is still a thrown exception, unchanged from
  before.
- `FirebasePortalAnalysisClient` (today's direct Firebase AI Logic adapter)
  now implements `PortalInferenceGateway` directly and remains the adapter
  wired by default in `lib/core/integration/portal_sync/school_portal_page.dart`.
  It never returns a rejection — it has no entitlement check to reject
  against — and nothing about its behavior, limits, or risk changed.
- `packages/portal_sync/lib/src/data/datasources/callable_inference_gateway.dart`
  adds `CallableInferenceGateway`, a second `PortalInferenceGateway`
  implementation that calls a `cloud_functions` `httpsCallable` against a
  *documented* request/response contract (account identity, a budget key,
  the same bounded structural payload the direct client sends; either a
  plan or a typed rejection back). **No such callable exists.** The class's
  doc comment states this plainly. Because `cloud_functions`'s
  `HttpsCallable` has a library-private constructor and cannot be
  constructed or faked from outside the plugin, the gateway is built around
  an injected `HttpsCallableInvoker` function — the actual seam tests use —
  rather than a mocked SDK object; its default implementation performs the
  real `cloud_functions` call a deployment would receive. Verified in
  `packages/portal_sync/test/data/callable_inference_gateway_test.dart`
  against a fake invoker: request shape, response parsing, typed-rejection
  handling, and bounded retry/backoff on transient codes. None of this
  touches a live Firebase project.
- `packages/portal_sync/lib/src/domain/entities/portal_identity_bridge.dart`
  declares `PortalIdentityBridge`, the client contract for "verify the
  existing [Verisafe] session and issue a Firebase custom token tied to the
  same account" from the plan's Phase 3 row. `endpoint_portal_identity_bridge.dart`
  adds `EndpointPortalIdentityBridge`, the client that would perform this
  exchange against a real endpoint — it takes the endpoint as an injected
  `PortalIdentityBridgeEndpoint` function with **no default and no
  production implementation anywhere in this repository**, specifically so
  nothing can silently call a guessed URL. `lib/core/integration/portal_sync/verisafe_identity_bridge_client.dart`
  adds the app-level driver, `VerisafePortalIdentityBridgeClient`, which
  reads the student's current Verisafe access token and forwards it to an
  injected bridge. It is gated by `portalIdentityBridgeEnabled`
  (`--dart-define=PORTAL_IDENTITY_BRIDGE_ENABLED`, default `false`,
  following the same pattern as `PORTAL_SYNC_ENABLED` /
  `PORTAL_BYPASS_SUBSCRIPTION`) and is **not wired into
  `school_portal_page.dart` or `injection_container.dart`** — flipping the
  flag alone enables nothing. Verified against fakes in
  `packages/portal_sync/test/data/endpoint_portal_identity_bridge_test.dart`
  and `test/core/integration/portal_sync/verisafe_identity_bridge_client_test.dart`.
- Local usage-store/controller check against the plan's stated client-side
  rules (per-account persistence surviving reconnects; one in-flight
  analysis per connection; bounded single retry): the first and third were
  already correctly implemented and are now covered by added regression
  tests. The second had a real gap — `PortalSyncController.setConnection`
  and `.stop()` left the old connection's in-flight `Future` occupying the
  single-in-flight slot, so a capture on a *new* connection would wait
  behind an abandoned call (up to the 30s analysis timeout) instead of
  running immediately. Fixed by freeing the slot in both methods and
  guarding the in-flight future's completion callback so a stale
  generation can no longer steal a snapshot queued by the new one. Covered
  by a new regression test in `packages/portal_sync/test/presentation/portal_sync_controller_test.dart`
  ("setConnection frees the in-flight slot for the new connection
  immediately"). This is still a local, client-side, bypassable control —
  exactly as already documented above — not server enforcement.

What this pass explicitly does **not** claim or provide:

- No deployed, server-verified callable function. `CallableInferenceGateway`
  is untested against a real backend and is not registered anywhere in app
  composition.
- No real Verisafe-to-Firebase token exchange. No endpoint URL was invented;
  `EndpointPortalIdentityBridge`/`VerisafePortalIdentityBridgeClient` are
  verified only against fakes and are not wired into app startup.
- No atomic server-side usage reservation, reconciliation, or budget policy.
- No change to the actual risk profile of the pilot: a modified client can
  still bypass every control in this repository today, exactly as the
  "Cost and abuse controls" section of [the full plan](portal-sync-plan.md)
  already warns. Distribution must stay limited to trusted testers until a
  real server enforcement layer — built and deployed outside this
  repository — is wired in and verified against a live deployment.

## Known defects found in review

A code review on 2026-10-10 of the four phase slices found the following, none of
them fixed yet. They are listed worst first. The three marked **verified** were
re-confirmed directly against the source; the rest are the review's findings at
the cited line.

Feature-blocking:

- `firebase_portal_analysis_client.dart:141` — **verified.** The request schema and
  system instruction were never extended for profile/fees, so that whole path is
  unreachable from a real portal. See the note under "Profile and fees" above.

Silent data loss or wrong data:

- `portal_profile_fee_draft_extractor.dart:92` — the occurrence key includes
  `rawAmount` but `sourceId` does not, so two fee rows sharing a description and
  kind but differing in amount collide and one is dropped without notice.
- `portal_sync_controller.dart:422` — a DOM capture emits
  `clearDraft: draft == null`, discarding a draft `analyzeMediaFallback` just
  produced; the next snapshot on an unreadable page throws away the
  media-extracted courses before the student can save them.
- `academia_portal_calendar_importer.dart:87` — **verified.** Parsed `VTIMEZONE`
  offsets are never applied; `deadline.start` goes straight into `due`, so a
  `TZID` deadline lands at a device-local wall clock and the wrong instant
  whenever the zones differ. This contradicts the timezone rule this document
  states for calendar imports.
- `monetary_amount.dart:109` — **verified.** The sign is dropped whenever the
  integer part normalizes to `0`, so a credit of `(0.75)` parses as `0.75`, losing
  the minus. A four-digit trailing group is also treated as thousands, so
  `"1.2345"` becomes `12345.00` rather than being rejected.

Cost and correctness:

- `portal_sync_controller.dart:571` — `analyzeMediaFallback` tests `_state.isBusy`
  but only sets it after two awaits, so concurrent calls each spend a usage
  attempt and make a separate billable model call.
- `portal_analysis_plan.dart:437` — `supportedSubsetFor` dedupes fields by
  `fieldKey` alone while the validator also rejects duplicate `nodeId`, so the
  repair path can hand back a plan that still fails validation and the page errors
  out instead of recovering.

Lower severity:

- `institution_home_page.dart:67` — the legacy import flow is deleted while every
  replacement entry point sits behind `portalSyncEnabled` (default `kDebugMode`),
  so a release build has no import path at all. The deleted flow was already
  non-functional against the current Professor checkout, so this removes a broken
  path rather than a working one, but it should be a deliberate decision.
- `shared_preferences_institution_fee_repository.dart:129` — `clearAccount` never
  removes the `_indexPrefix` term index it iterates, leaving records behind on
  disconnect where the retention rule expects them deleted.
- `institution_records_cubit.dart:37` — emits after awaits with no `isClosed`
  guard and without the repo's existing `SafeCubit`, so disposing mid-load throws.
- `ics_feed_fetcher.dart:45` — the constructor rewrites the injected `Dio`'s global
  `BaseOptions`; passing the app's shared `Dio` would change every other request's
  timeouts and redirect behavior.

What the review confirmed as sound: the fetcher's SSRF guardrails and per-hop
re-validation, the bounded ICS parser, the `_captureFuture`/generation race fixes
in `capture`/`stop`/`setConnection`, the cache key genuinely including
`promptVersion` and `schemaVersion` (so the v2/v3 bump does invalidate stale
plans), and the merge-not-replace semantics in `AcademicProfileEntity.mergedWith`
and `FeeStatementEntity.mergedWith`.

## Verification

Run from the repository root after `flutter pub get`:

```sh
flutter test packages/portal_sync/test packages/institutions/test packages/magnet/test test/core/integration/portal_sync
flutter analyze packages/portal_sync/lib packages/institutions/lib packages/magnet/lib/src/observer lib/core/integration/portal_sync
```

Verified on 2026-10-06 (all four slices integrated on one branch):

These are the authoritative numbers for the merged branch. The per-slice entries
below were each measured on their own branch before integration, so their test
counts are lower than the combined total and do not reflect the interface
reconciliation the merge required.

- Combined suite (`packages/portal_sync/test`, `packages/institutions/test`,
  `packages/magnet/test`, `test/core/integration/portal_sync`): **191 tests
  passed**.
- Scoped analyzer across `packages/portal_sync`, `packages/institutions`,
  `lib/core/integration/portal_sync` and `test/core/integration/portal_sync`:
  no issues found.
- App-wide `flutter analyze lib test`: 68 issues, byte-identical to the
  pre-merge baseline. All 68 predate this work (lint infos/warnings in
  `chirp`/`streaks`/`leaderboard`/`core/network` plus `undefined_identifier`
  errors in the generated `test/drift/academia/generated/schema_v*.dart`
  fixtures). This work added none.
- Integration fix applied during the merge: the Phase 3 pass replaced
  `PortalAnalysisClient` with `PortalInferenceGateway`, so
  `PortalProfileFeeController` (from the profile/fees slice, developed in
  parallel) was migrated onto the same gateway rather than left on the removed
  interface. Profile/fee analysis therefore goes through the one adapter seam a
  future server-verified gateway will cover, instead of an unenforced parallel
  path. The shared rejection copy lives on
  `PortalInferenceRejectionCopy.studentMessage` so both controllers word an
  entitlement/allowance rejection identically.
- `cloud_functions` (added by the Phase 3 pass to `packages/portal_sync`)
  requires a root `flutter pub get` after merging; without it the root test
  resolution cannot compile the package even though a package-scoped analyze
  passes.

Verified on 2026-10-06 (profile/fees slice, pre-integration):

- Portal package: 60 tests passed (47 existing courses/timetable tests plus 13
  new: `PortalAnalysisPlan`'s profile/fee categories, the
  `PortalProfileFeeDraftExtractor`, and `PortalProfileFeeController`). Institutions
  package (new): 21 tests passed, covering `AcademicProfileEntity`,
  `FeeStatementEntity`/`MonetaryAmount` (including non-KES currencies, localized
  decimal/thousands-separator parsing, and never defaulting an unknown
  currency/amount), and the `SharedPreferences` repositories' merge-not-duplicate
  behavior. App portal integration: 29 tests passed (23 existing plus 6 new for
  `AcademiaInstitutionPortalImporter`: new-record save, retry without duplicating,
  updated-value re-import, manual-edit preservation, partial-capture-never-deletes,
  and account-change stops writes).
- Scoped analyzer across `packages/portal_sync/lib`, `packages/institutions/lib`,
  `lib/core/integration/portal_sync` and their test directories: no issues found.
  `git diff --check` passed.
- Magnet/Firefox capture checks below were not re-run for this slice; they are
  unaffected by the profile/fee additions, which touch only `portal_sync`'s
  domain/presentation layers, the new `institutions` package, and the new
  `academia_institution_importer.dart` adapter.
- Not verified for the profile/fees slice: any live Firebase/Gemini call against
  the new `profile`/`feeStatement` schema, and any real school portal or device
  session. `PortalProfileFeeController`/`PortalProfileFeeReview` and
  `AcademiaInstitutionPortalImporter` are not wired into the app's composition root
  or navigation (see "Profile and fees (phase 2 slice)" above), so they have not
  been exercised through the shipped UI at all.

Verified on 2026-10-06 (calendar feed import and document/image fallback,
pre-integration):

- Portal package: 80 tests passed (39 prior + 41 new), covering: ICS parsing
  (valid feed, weekly `RRULE`, `EXDATE` exceptions, a missing-timezone event
  forced to needs-review, an unfolded continuation line, a `VTIMEZONE` offset,
  and malformed/unbalanced/oversized/no-UID rejections); the feed fetcher
  (successful fetch, non-HTTPS rejection, private/link-local host rejection,
  oversized-response rejection, a followed same-origin redirect, a rejected
  downgrade-to-HTTP redirect, a rejected redirect to a private host, and a
  too-many-redirects rejection) against a scripted `HttpClientAdapter` fake —
  no real network access; calendar event classification and stable,
  account-scoped source-identity hashing; `PortalMediaSelection` byte/PNG-pixel
  ceilings and mime-type allowlisting; `FirebasePortalAnalysisClient.analyzeMedia`
  request/schema construction (same capture-the-SDK-config technique as the
  existing DOM test, since `GenerativeModel` cannot be subclassed); and the
  media fallback's usage-counter interaction with `PortalSyncController`
  (shared allowance with the DOM path, a failed call still spends an attempt,
  access-denial and limit-reached block before any model call, a no-op when
  no media client is injected, and an on-device DOM value winning over a
  media-extracted duplicate on merge).
- App portal integration: 23 tests passed, unaffected by this change (no
  existing file in `lib/core/integration/portal_sync` was modified; the two
  new adapters there — `academia_portal_calendar_importer.dart` and
  `academia_portal_media_picker.dart` — are additive and not yet wired into
  any screen or the DI container).
- Scoped analyzer (`packages/portal_sync/lib`, `packages/portal_sync/test`,
  `lib/core/integration/portal_sync`): no issues found.
- Not verified: `packages/agenda/test` does not exist in this checkout (no
  agenda package tests to run), which predates this change and is unrelated
  to it. `magnet` package: 9 existing tests still pass, unaffected (untouched
  by this change).
- Not verified at all (by design, per the task's environment notes — no app
  build/launch was attempted): a real Canvas/Moodle calendar feed, a live
  Gemini multimodal `analyzeMedia` call, the on-device image/document picker
  UX, and the `PortalMediaFallbackPrompt`/calendar-feed widgets rendered in a
  running app (neither is wired into `portal_sync_page.dart` yet).

Verified on 2026-10-06 (Phase 3 Flutter-side seam pass, pre-integration):

- Combined suite (portal package, Magnet, app portal integration): 102 tests
  passed, including the new `PortalInferenceGateway`/`CallableInferenceGateway`/
  `PortalIdentityBridge` coverage, the usage-store/controller reconnect-slot
  regression test, and the existing real Firebase SDK serializer, mapping
  recovery, review, save and cached-timetable-update tests.
- Scoped analyzer across `packages/portal_sync/lib`,
  `packages/magnet/lib/src/observer` and `lib/core/integration/portal_sync`:
  no issues found. `git diff --check` passed.
- No live Firebase project, Cloud Function, or identity-bridge endpoint was
  contacted or exercised by any of the above — see "Phase 3: Flutter-side
  seam scaffolding (not enforcement)" above for exactly what remains
  unverified.

Verified on 2026-10-05 (courses/timetable slice):

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
