import 'package:academia/constants/constants.dart';
import 'package:academia/features/sherehe/presentation/bloc/scanner_actions/scanner_actions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ShereheUtils {
  /// Extracts initials from a name
  static String getInitials(String name) {
    if (name.trim().isEmpty) return "?";

    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return parts.first[0].toUpperCase() + parts.last[0].toUpperCase();
  }

  /// Formats an ISO date string (e.g. 2025-11-20)
  static String formatDate(String isoString, {String pattern = 'dd MMM yyyy'}) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat(pattern).format(dateTime);
    } catch (_) {
      return isoString;
    }
  }

  /// Formats time from an ISO string
  static String formatTime(String isoString, {String pattern = 'hh:mm a'}) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat(pattern).format(dateTime);
    } catch (_) {
      return isoString;
    }
  }

  static int getCrossAxisCount(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) return 1;
    if (ResponsiveBreakPoints.isTablet(context)) return 2;
    return 3;
  }

  static double getMainAxisExtent(BuildContext context) {
    return ResponsiveBreakPoints.isMobile(context) ? 440 : 500;
  }

  static void showScannerActionsBottomSheet({
    required BuildContext context,
    required String scannerName,
    required String scannerId,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Scanner Actions",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              scannerName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),

            ListTile(
              leading: Icon(
                Icons.person_remove_alt_1,
                color: Theme.of(context).colorScheme.error,
              ),
              title: const Text("Remove Scanner"),
              subtitle: const Text(
                "This user will no longer be able to scan tickets",
              ),
              onTap: () {
                Navigator.pop(context); // close bottom sheet
                ShereheUtils.confirmRemoveScanner(
                  context,
                  scannerName: scannerName,
                  scannerId: scannerId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static void confirmRemoveScanner(
    BuildContext context, {
    required String scannerName,
    required String scannerId,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) =>
          BlocListener<ScannerActionsBloc, ScannerActionsState>(
            listener: (context, state) {
              if (state is DeleteScannerSuccess) {
                Navigator.pop(dialogContext); // closes the dialog
              } else if (state is DeleteScannerError) {
                Navigator.pop(dialogContext); // closes the dialog
              }
            },
            child: AlertDialog(
              title: const Text("Remove Scanner"),
              content: Text(
                "Are you sure you want to remove $scannerName as a scanner?\n\n"
                "They will no longer be able to scan tickets for this event.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                BlocBuilder<ScannerActionsBloc, ScannerActionsState>(
                  builder: (context, state) {
                    return state is DeleteScannerLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                            ),
                            onPressed: () {
                              context.read<ScannerActionsBloc>().add(
                                DeleteScanner(scannerId: scannerId),
                              );
                            },
                            child: const Text("Remove"),
                          );
                  },
                ),
              ],
            ),
          ),
    );
  }

  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final name = parts[0];
    final domain = parts[1];

    if (name.length <= 2) {
      return '${name[0]}***@$domain';
    }

    final visible = name.substring(0, 2);
    return '$visible****@$domain';
  }
}
