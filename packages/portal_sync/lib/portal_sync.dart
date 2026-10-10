library;

export 'src/diagnostics/portal_debug_log.dart';
export 'src/domain/entities/portal_connection.dart';
export 'src/domain/entities/portal_snapshot.dart';
export 'src/domain/entities/portal_analysis_plan.dart';
export 'src/domain/entities/portal_draft.dart';
export 'src/domain/entities/portal_draft_extractor.dart';
export 'src/domain/entities/portal_inference_outcome.dart';
export 'src/domain/entities/portal_profile_fee_draft.dart';
export 'src/domain/entities/portal_profile_fee_draft_extractor.dart';
export 'src/domain/entities/portal_source_identity.dart';
export 'src/domain/repositories/portal_sync_repositories.dart';
export 'src/data/datasources/callable_inference_gateway.dart';
export 'src/data/datasources/endpoint_portal_identity_bridge.dart';
export 'src/data/datasources/firebase_portal_analysis_client.dart';
export 'src/data/repositories/shared_preferences_portal_cache_store.dart';
export 'src/data/repositories/shared_preferences_portal_usage_store.dart';
export 'src/presentation/portal_profile_fee_controller.dart';
export 'src/presentation/portal_profile_fee_state.dart';
export 'src/presentation/portal_sync_controller.dart';
export 'src/presentation/portal_sync_state.dart';
export 'src/presentation/screens/portal_sync_page.dart';
export 'src/presentation/widgets/portal_profile_fee_review.dart';

// Calendar subscription (.ics feed) import path.
export 'src/domain/entities/ics_calendar_event.dart';
export 'src/domain/entities/ics_feed_url_policy.dart';
export 'src/domain/entities/portal_calendar_draft.dart';
export 'src/data/datasources/ics_calendar_parser.dart';
export 'src/data/datasources/ics_feed_fetcher.dart';
export 'src/presentation/portal_calendar_feed_controller.dart';
export 'src/presentation/portal_calendar_feed_state.dart';

// Document/image fallback import path.
export 'src/domain/entities/portal_media_analysis_request.dart';
export 'src/domain/entities/portal_media_extraction_plan.dart';
export 'src/domain/entities/portal_media_selection.dart';
export 'src/presentation/widgets/portal_media_fallback_prompt.dart';
