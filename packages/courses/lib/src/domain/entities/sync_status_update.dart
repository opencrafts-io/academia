class SyncStatusUpdate {
  const SyncStatusUpdate({
    required this.id,
    required this.status,
    this.serverId,
    this.error,
    this.archivedAt,
    this.isScheduleEntry = false,
  });

  final String id;
  final String status;
  final String? serverId;
  final String? error;
  final DateTime? archivedAt;
  final bool isScheduleEntry;
}
