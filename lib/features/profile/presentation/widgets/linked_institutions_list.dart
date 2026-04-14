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
        if (state is InstitutionLinkedState) {
          final profileState = context.read<ProfileBloc>().state;

          if (profileState is! ProfileLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "Cannot retrieve your institutions at the moment",
                ),
              ),
            );

            return;
          }

          context.read<InstitutionBloc>().add(
            GetCachedUserInstitutionsEvent(profileState.profile.id),
          );
        }
      },
      builder: (context, state) => state is! InstitutionLoadedState
          ? Center(child: LoadingIndicatorM3E())
          : Card(
              clipBehavior: Clip.hardEdge,
              color: Theme.of(context).colorScheme.tertiaryContainer,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final institution = state.institutions[index];
                  return Slidable(
                    key: Key(index.toString()),
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.link_off_outlined,
                          onPressed: (_) {
                            final profileState = context
                                .read<ProfileBloc>()
                                .state;

                            if (profileState is! ProfileLoadedState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "Cannot unlink from institution at the moment",
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
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.errorContainer,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onErrorContainer,
                          label: "Unlink institution",
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () => InstitutionHomePageRoute(
                        institutionID: institution.institutionId,
                      ).push(context),
                      leading: Assets.icons.motarboard.image(),
                      title: Text(institution.name),
                      subtitle: Text("Swipe right for more actions"),
                      trailing: Icon(Icons.open_in_new),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                  child: Divider(),
                ),
                itemCount: state.institutions.length,
              ),
            ),
    );
  }
}
