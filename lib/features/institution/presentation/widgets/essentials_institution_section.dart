import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/magnet/magnet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:vibration/vibration.dart';

class EssentialsInstitutionSection extends StatelessWidget {
  const EssentialsInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MagnetBloc, MagnetState>(
      buildWhen: (previous, current) =>
          current is MagnetInstancesLoadedState || current is MagnetErrorState,
      builder: (context, magnetState) {
        if (magnetState is MagnetInitialState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return BlocBuilder<InstitutionBloc, InstitutionState>(
          buildWhen: (previous, current) =>
              current is InstitutionLoadedState ||
              current is InstitutionErrorState,
          builder: (context, institutionState) {
            if (institutionState is! InstitutionLoadedState) {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }

            final magnetBloc = context.read<MagnetBloc>();

            return SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: MultiSliver(
                children: [
                  Text(
                    "Features offered by your school",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SliverList.builder(
                    itemCount: institutionState.institutions.length,
                    itemBuilder: (context, index) {
                      final ins = institutionState.institutions[index];
                      final isSupported = magnetBloc.isInstitutionSupported(
                        ins.institutionId,
                      );

                      return Card.filled(
                        color: isSupported
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(
                                context,
                              ).colorScheme.errorContainer.withAlpha(128),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          enabled: isSupported,
                          title: Text(
                            ins.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: isSupported
                              ? () async {
                                  if (await Vibration.hasVibrator()) {
                                    Vibration.vibrate(
                                      pattern: [0, 50, 100, 50, 100, 100],
                                      intensities: [0, 128, 0, 128, 0, 128],
                                    );
                                  }
                                  if (!context.mounted) return;
                                  MagnetHomeRoute(
                                    institutionID: ins.institutionId,
                                  ).push(context);
                                }
                              : null,
                          trailing: Icon(
                            isSupported ? Icons.verified_outlined : Icons.lock,
                          ),
                          subtitle: Text(
                            isSupported
                                ? "Tap to explore features"
                                : "Not yet supported on Academia",
                          ),
                          subtitleTextStyle: Theme.of(
                            context,
                          ).textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
