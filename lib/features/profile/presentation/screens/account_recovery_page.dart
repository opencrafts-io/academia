import 'package:academia/config/config.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:drift/drift.dart' as drift;

class AccountRecoveryPage extends StatelessWidget {
  final DateTime deletedAt;
  final VoidCallback onRecover;

  const AccountRecoveryPage({
    super.key,
    required this.deletedAt,
    required this.onRecover,
  });

  int get daysRemaining {
    final expiryDate = deletedAt.add(Duration(days: 14));
    final now = DateTime.now();
    final difference = expiryDate.difference(now);
    return difference.inDays > 0 ? difference.inDays : 0;
  }

  DateTime get deletionScheduledAt {
    return deletedAt.add(Duration(days: 14));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Academia Logo
                  Image.asset(
                    "assets/icons/academia.png",
                    width: 80,
                    height: 80,
                  ),

                  SizedBox(height: 32),
                  Text(
                    'Account Scheduled for Deletion',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 16),

                  // Days remaining countdown
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.error.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Symbols.schedule,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '$daysRemaining ${daysRemaining == 1 ? 'day' : 'days'} remaining',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Description
                  Text(
                    'Your account was previously marked for deletion and will be permanently deleted on:',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8),

                  Text(
                    _formatDate(deletionScheduledAt),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32),

                  // Info card
                  Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Symbols.info,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'What happens next?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          _InfoItem(
                            'Recover your account now to restore full access',
                          ),
                          _InfoItem(
                            'If you do nothing, your account will be permanently deleted',
                          ),
                          _InfoItem(
                            'After deletion, all your data will be lost forever',
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 32),

                  // Action buttons
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      final isLoading = state is ProfileLoadingstate;

                      return Column(
                        spacing: 12,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              onPressed: isLoading ? null : onRecover,
                              icon: isLoading
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(Symbols.restore),
                              label: Text(
                                isLoading
                                    ? 'Recovering Account...'
                                    : 'Recover My Account',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.error,
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () => _showLogoutConfirmation(context),
                              icon: Icon(Symbols.logout),
                              label: Text(
                                'Logout',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(
          Symbols.logout,
          size: 48,
          color: Theme.of(context).colorScheme.error,
        ),
        title: Text('Logout Without Recovery?'),
        content: Text(
          'If you logout without recovering your account, it will still be deleted on the scheduled date.\n\nAre you sure you want to logout?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              Navigator.pop(dialogContext);

              final appDb = sl.get<AppDataBase>();
              final tables = appDb.allTables;
              for (final table in tables) {
                await table.deleteAll();
              }

              if (!context.mounted) return;
              context.read<AuthBloc>().add(AuthCheckStatusEvent());
              AuthRoute().go(context);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String text;

  const _InfoItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Expanded(child: Text(text, style: TextStyle(fontSize: 13)))],
      ),
    );
  }
}
