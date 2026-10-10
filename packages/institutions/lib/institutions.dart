/// Institution directory, academic student profile, and fee record
/// subsystem. See `docs/portal-sync-plan.md`'s package boundary table:
/// "Directory, memberships, academic student profile, fee records,
/// repositories, and institution-facing screens."
///
/// This package must not import `package:academia/...` or any internal
/// (non-exported) file from `package:portal_sync`. Portal capture, AI
/// analysis, and extraction stay in `packages/portal_sync`; this package
/// only owns the saved, evidenced academic records and their storage.
library;

export 'src/data/data.dart';
export 'src/di/institutions_injection.dart';
export 'src/domain/domain.dart';
export 'src/presentation/presentation.dart';
