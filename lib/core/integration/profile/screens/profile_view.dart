import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/linked_institutions_list.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) => ProfileScreen(
    onRefresh: () => _refresh(context),
    onOpenPasswordSettings: () => _openPasswordSettings(context),
    onLinkInstitution: () => LinkInstitutionProfileRoute().push(context),
    onSignOut: () => _signOut(context),
    linkedInstitutionsBuilder: (_) => const LinkedInstitutionsList(),
  );

  Future<void> _refresh(BuildContext context) async {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<InstitutionBloc>().add(
        RefreshUserInstitutionsEvent(profileState.profile.id),
      );
    }
    context.read<ProfileBloc>().add(RefreshProfileEvent());
    await Future<void>.delayed(const Duration(milliseconds: 800));
  }

  Future<void> _openPasswordSettings(BuildContext context) async {
    final saved = await PasswordSettingsRoute().push<bool>(context);
    if (!context.mounted || saved != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password saved.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    context.read<AuthBloc>().add(const AuthSignOutEvent());
    final appDb = sl<AppDataBase>();
    for (final table in appDb.allTables) {
      await appDb.delete(table).go();
    }
    if (context.mounted) AuthRoute().go(context);
  }
}
