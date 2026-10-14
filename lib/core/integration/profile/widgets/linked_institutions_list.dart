import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/features.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class LinkedInstitutionsList extends StatelessWidget {
  const LinkedInstitutionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstitutionBloc, InstitutionState>(
      listener: (context, state) {
        state.whenOrNull(
          linked: () {
            final profileState = context.read<ProfileBloc>().state;

            if (profileState is! ProfileLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Cannot retrieve your institutions right now.'),
                ),
              );

              return;
            }

            context.read<InstitutionBloc>().add(
              GetCachedUserInstitutionsEvent(profileState.profile.id),
            );
          },
        );
      },
      builder: (context, state) {
        final institutions = state.whenOrNull(
          loaded: (institutions) => institutions,
        );
        if (institutions == null) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: LoadingIndicatorM3E()),
          );
        }
        if (institutions.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Row(
              children: [
                Icon(
                  Icons.school_outlined,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No institutions linked yet',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 8),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final institution = institutions[index];
            return Slidable(
              key: ValueKey(institution.institutionId),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    icon: Icons.link_off_outlined,
                    onPressed: (_) {
                      final profileState = context.read<ProfileBloc>().state;

                      if (profileState is! ProfileLoadedState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Cannot unlink from institution right now.',
                            ),
                          ),
                        );
                        return;
                      }
                      context.read<InstitutionBloc>().add(
                        UnLinkAccountFromInstitutionEvent(
                          accountID: profileState.profile.id,
                          institutionID: institution.institutionId,
                        ),
                      );
                    },
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .errorContainer,
                    foregroundColor: Theme.of(context)
                        .colorScheme
                        .onErrorContainer,
                    label: 'Unlink',
                  ),
                ],
              ),
              child: ListTile(
                onTap: () => InstitutionHomePageRoute(
                  institutionID: institution.institutionId,
                ).push(context),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                leading: Assets.icons.motarboard.image(width: 28, height: 28),
                title: Text(institution.name),
                subtitle: const Text('Swipe to unlink'),
                trailing: Icon(
                  Icons.open_in_new_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 1,
            indent: 76,
            endIndent: 24,
            color: Theme.of(context).colorScheme.outlineVariant
                .withValues(alpha: 0.5),
          ),
          itemCount: institutions.length,
        );
      },
    );
  }
}
