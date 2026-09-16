import 'package:academia/config/config.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:academia/gen/assets.gen.dart';

class EssentialsInstitutionSection extends StatelessWidget {
  const EssentialsInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (institutions) => ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final institution = institutions[index];
              return _InstitutionCard(institution: institution);
            },
            itemCount: institutions.length,
          ),
          loading: () => Skeletonizer(
            enabled: true,
            child: Card.filled(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text("Hogwart's School"),
                subtitle: Text("https://some-dummy-institution.ac.ke"),
                trailing: Icon(Icons.open_in_new_rounded),
                leading: CircleAvatar(
                  radius: 24,
                  child: Icon(Icons.school_rounded),
                ),
              ),
            ),
          ),
          orElse: () => SizedBox.shrink(),
        );
      },
    );
  }
}

class _InstitutionCard extends StatelessWidget {
  const _InstitutionCard({required this.institution});
  final Institution institution;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card.filled(
      color: colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () => InstitutionHomePageRoute(
          institutionID: institution.institutionId,
        ).push(context),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: colorScheme.tertiaryContainer,
          child: Assets.icons.motarboard.image(height: 26),
        ),
        title: Text(
          institution.name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(institution.domains?.first ?? ''),
        trailing: Icon(
          Icons.open_in_new_rounded,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
