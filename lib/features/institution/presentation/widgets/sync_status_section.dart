import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';

class SyncStatusSection extends StatelessWidget {
  const SyncStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scrappingState = context.watch<ScrappingCommandBloc>().state;
    final magnetState = context.watch<MagnetBloc>().state;
    final keyState = context.watch<InstitutionKeyBloc>().state;

    final scrappingCommand = scrappingState.maybeWhen(
      loaded: (command) => command,
      orElse: () => null,
    );
    final institutionKey = keyState.maybeWhen(
      loaded: (key) => key,
      orElse: () => null,
    );
    final bool magnetIsReadyOrSuccess = magnetState.maybeWhen(
      ready: (magnet) => true,
      success: (result) => true,
      orElse: () => false,
    );
    final bool magnetIsProcessing = magnetState.maybeWhen(
      processing: (command, progress) => true,
      orElse: () => false,
    );

    // Condition logic moved here for readability
    final bool canExecute =
        magnetIsReadyOrSuccess &&
        scrappingCommand != null &&
        institutionKey != null;

    final bool shouldShow = canExecute && !magnetIsProcessing;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: shouldShow
          ? Card.filled(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                onTap: () =>
                    _handleSync(context, scrappingCommand, institutionKey),
                leading: const Icon(Icons.sync_rounded),
                title: const Text("Sync your information"),
                subtitle: const Text("Update your profile and courses now"),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  void _handleSync(
    BuildContext context,
    ScrappingCommand? scrappingCommand,
    InstitutionKey? institutionKey,
  ) {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState &&
        scrappingCommand != null &&
        institutionKey != null) {
      context.read<MagnetBloc>().add(
        ExecuteScrappingCommand(
          institutionID: institutionKey.institutionId,
          userID: profileState.profile.id,
          command: scrappingCommand,
          institutionKey: institutionKey,
        ),
      );
    }
  }
}
