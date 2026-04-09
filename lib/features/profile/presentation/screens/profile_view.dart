import 'package:academia/config/config.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/injection_container.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:time_since/time_since.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    final profileState = BlocProvider.of<ProfileBloc>(context).state;

    if (profileState is ProfileLoadedState) {
      context.read<InstitutionBloc>().add(
        GetCachedUserInstitutionsEvent(profileState.profile.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is AccountDeletionRequestedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
            ),
          );
          // logout after deletion request
          Future.delayed(Duration(seconds: 1), () async {
            final appDb = sl.get<AppDataBase>();
            final tables = appDb.allTables;
            for (final table in tables) {
              await table.deleteAll();
            }
            if (!context.mounted) return;
            context.read<AuthBloc>().add(AuthCheckStatusEvent());
            AuthRoute().go(context);
          });
        }
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            final profileState = context.read<ProfileBloc>().state;

            if (profileState is ProfileLoadedState) {
              context.read<InstitutionBloc>().add(
                RefreshUserInstitutionsEvent(profileState.profile.id),
              );
            }

            BlocProvider.of<ProfileBloc>(context).add(RefreshProfileEvent());
            return Future.delayed(Duration(seconds: 2));
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is! ProfileLoadedState) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      snap: true,
                      pinned: true,
                      floating: true,
                      title: Text("Profile"),
                    ),
                    SliverFillRemaining(
                      child: Center(
                        child: state is ProfileErrorState
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline, size: 48),
                                  SizedBox(height: 16),
                                  Text("Failed to load profile"),
                                  SizedBox(height: 16),
                                  TextButton(
                                    onPressed: () {
                                      context.read<ProfileBloc>().add(
                                        RefreshProfileEvent(),
                                      );
                                    },
                                    child: Text("Retry"),
                                  ),
                                ],
                              )
                            : CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              }
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    snap: true,
                    pinned: true,
                    floating: true,
                    title: Text("Profile"),
                    actions: [
                      Visibility(
                        visible: kDebugMode,
                        child: IconButton(
                          icon: Icon(Icons.token),
                          onPressed: () {
                            final token =
                                (BlocProvider.of<AuthBloc>(context).state
                                        as AuthAuthenticated)
                                    .token;
                            Clipboard.setData(
                              ClipboardData(text: token.accessToken),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Debug token copied to system clipboard",
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        constraints: BoxConstraints(
                          maxWidth: ResponsiveBreakPoints.mobile,
                        ),
                        child: Column(
                          spacing: 0,
                          children: [
                            UserAvatar(radius: 60),
                            SizedBox(height: 12),
                            Text(
                              state.profile.name,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              "@${state.profile.username?.toLowerCase() ?? 'anonymous'}",
                            ),

                            SizedBox(height: 12),
                            SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Your Academia Profile",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              margin: EdgeInsets.all(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.vertical(
                                  top: Radius.circular(12),
                                  bottom: Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Symbols.person_filled),
                                title: Text(state.profile.name),
                                subtitle: Text(
                                  "Your full name",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              margin: EdgeInsets.all(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.zero,
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Symbols.numbers),
                                title: Text(
                                  state.profile.nationalID ??
                                      'Please update your national ID',
                                ),
                                subtitle: Text(
                                  "National Identification Number",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              margin: EdgeInsets.all(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Symbols.phone),
                                title: Text(
                                  state.profile.phone ??
                                      'Please update your phone number',
                                ),
                                subtitle: Text(
                                  "Your phone number",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.zero,
                              ),
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              margin: EdgeInsets.all(0.5),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Symbols.email),
                                title: Text(state.profile.email),
                                subtitle: Text(
                                  "Your personal email",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              margin: EdgeInsets.all(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.vertical(
                                  bottom: Radius.circular(8),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Symbols.today),
                                title: Text(timeSince(state.profile.createdAt)),
                                subtitle: Text(
                                  "Time since you joined Academia",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),

                            SizedBox(height: 22),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Institution Actions",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              margin: EdgeInsets.all(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                              elevation: 0,
                              clipBehavior: Clip.hardEdge,
                              child: ListTile(
                                leading: Icon(Icons.add_link),
                                title: Text('Link your institution'),
                                subtitle: Text(
                                  "Access your institution's features from Academia",
                                ),
                                onTap: () =>
                                    LinkInstitutionProfileRoute().push(context),
                              ),
                            ),
                            SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Account Management",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),

                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.errorContainer,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  // Logout Button
                                  ListTile(
                                    leading: Icon(Icons.logout_outlined),
                                    title: Text("Logout"),
                                    subtitle: Text(
                                      "Clears your data from this device",
                                    ),
                                    onTap: () =>
                                        _showLogoutConfirmation(context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Divider(),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.delete_outlined),
                                    title: Text("Delete account"),
                                    subtitle: Text(
                                      "Deletes your account permanently.",
                                    ),
                                    onTap: () =>
                                        _showDeletionConfirmation(context),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 22),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text("Are you sure?"),
        content: Text(
          "Logging out will delete all your data on this device "
          "and you'll have to re-login.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Cancel"),
          ),
          TextButton.icon(
            icon: Icon(Icons.check_rounded),

            onPressed: () async {
              context.read<AuthBloc>().add(AuthSignOutEvent());
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
            label: Text("Yes, I'm sure"),
          ),
        ],
      ),
    );
  }

  void _showDeletionConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        icon: Icon(
          Symbols.warning,
          size: 48,
          color: Theme.of(context).colorScheme.error,
        ),
        title: Text('Delete Account?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This action will:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _WarningItem('Mark your account for deletion'),
            _WarningItem('Remove access to all your data'),
            _WarningItem('Allow 14 days for recovery'),
            _WarningItem('Permanently delete after 14 days'),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.error.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Symbols.info,
                    size: 20,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You can recover your account within 14 days',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          TextButton.icon(
            style: FilledButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProfileBloc>().add(RequestAccountDeletionEvent());
              context.read<AuthBloc>().add(AuthSignOutEvent());
            },
            icon: Icon(Icons.delete_forever_outlined),
            label: Text('Delete My Account'),
          ),
        ],
      ),
    );
  }
}

class _WarningItem extends StatelessWidget {
  final String text;

  const _WarningItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            Symbols.circle,
            size: 8,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
