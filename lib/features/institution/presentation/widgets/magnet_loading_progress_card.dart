import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';

class MagnetLoadingProgressCard extends StatelessWidget {
  const MagnetLoadingProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MagnetBloc, MagnetState>(
      builder: (context, state) {
        return state.maybeWhen(
          processing: (command, progress) {
            final percent = (progress?.progressPercent ?? 0) / 100;

            // Dynamic labels based on the instruction type
            final actionLabel = _getFriendlyLabel(progress?.instructionType);
            final statusDetail = _getStatusDetail(progress);

            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              color: theme.colorScheme.surfaceContainerHigh,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        _AnimatedStatusAvatar(status: progress?.status),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                actionLabel,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                statusDetail,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Percentage indicator
                        Text(
                          '${(percent * 100).toInt()}%',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Smooth M3 Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        value: percent > 0 ? percent : null,
                        minHeight: 8,
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress?.status == InstructionStatus.failed
                              ? theme.colorScheme.error
                              : theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    if (progress?.error != null) ...[
                      const SizedBox(height: 12),
                      _ErrorNote(message: progress!.error!),
                    ],
                  ],
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  String _getFriendlyLabel(String? type) {
    switch (type) {
      case 'extract':
        return 'Syncing data...';
      case 'click':
        return 'Navigating portal...';
      case 'fill-form':
        return 'Authenticating...';
      case 'wait':
        return 'Optimizing connection...';
      case 'jsCode':
        return 'Processing request...';
      default:
        return 'Connecting to institution';
    }
  }

  String _getStatusDetail(InstructionProgressEvent? progress) {
    if (progress == null) return "Initializing...";
    if (progress.status == InstructionStatus.failed) {
      return "Retrying connection...";
    }
    return "Step ${progress.instructionIndex} of ${progress.totalInstructions}";
  }
}

class _AnimatedStatusAvatar extends StatelessWidget {
  final InstructionStatus? status;
  const _AnimatedStatusAvatar({this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRunning = status == InstructionStatus.running;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isRunning
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isRunning
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.primary,
                ),
              )
            : Icon(
                status == InstructionStatus.completed
                    ? Icons.check_rounded
                    : Icons.sync_rounded,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
      ),
    );
  }
}

class _ErrorNote extends StatelessWidget {
  final String message;
  const _ErrorNote({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 14,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
