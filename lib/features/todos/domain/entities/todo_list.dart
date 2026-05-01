import 'package:equatable/equatable.dart';
import 'package:academia/features/features.dart';

class TodoList extends Equatable {
  final int localId;
  final String? id;
  final String title;
  final int? color;
  final bool isDefault;
  final SyncStatus syncStatus;
  final int taskCount;
  final DateTime? lastSyncedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPendingDeletion;

  const TodoList({
    required this.localId,
    this.id,
    required this.title,
    this.color,
    required this.isDefault,
    required this.syncStatus,
    required this.taskCount,
    this.lastSyncedAt,
    this.createdAt,
    this.updatedAt,
    required this.isPendingDeletion,
  });
  @override
  List<Object?> get props => [
    localId,
    id,
    title,
    color,
    isDefault,
    syncStatus,
    taskCount,
    lastSyncedAt,
    createdAt,
    updatedAt,
    isPendingDeletion,
  ];
}
