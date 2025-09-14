import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/magnet/magnet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class EssentialsInstitutionSection extends StatelessWidget {
  const EssentialsInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      buildWhen: (previous, current) =>
          current is InstitutionLoadedState || current is InstitutionErrorState,
      builder: (context, state) {
        if (state is! InstitutionLoadedState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: MultiSliver(
            children: [
              Text(
                "Features offered by your school",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                itemCount: state.institutions.length,
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                //   crossAxisSpacing: 1,
                //   mainAxisSpacing: 1,
                //   childAspectRatio: 3 / 2,
                // ),
                itemBuilder: (context, index) {
                  final ins = state.institutions[index];
                  final isSupported = context
                      .read<MagnetBloc>()
                      .isInstitutionSupported(ins.institutionId);
                  return Card.filled(
                    color: isSupported
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withAlpha(128),

                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      enabled: isSupported,
                      title: Text(ins.name, overflow: TextOverflow.ellipsis),
                      onTap: () async {
                        if (await Vibration.hasVibrator()) {
                          Vibration.vibrate(
                            preset: VibrationPreset.gentleReminder,
                          );
                        }
                        if (!context.mounted) return;
                        MagnetHomeRoute(
                          institutionID: ins.institutionId,
                        ).push(context);
                      },
                      trailing: Icon(
                        isSupported
                            ? Icons.verified_outlined
                            : Icons.lock,
                      ),
                      subtitle: Text(
                        isSupported
                            ? "Tap to explore features"
                            : "Not yet supported on Academia",
                      ),
                      subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
