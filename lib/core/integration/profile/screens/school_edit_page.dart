import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';

class SchoolEditPage extends StatefulWidget {
  const SchoolEditPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<SchoolEditPage> createState() => _SchoolEditPageState();
}

class _SchoolEditPageState extends State<SchoolEditPage> {
  Institution? _selectedInstitution;
  final SearchController _searchController = SearchController();
  UserProfile? _profile;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileLoadedState) _profile = state.profile;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocListener<InstitutionBloc, InstitutionState>(
      listener: (context, state) {
        state.whenOrNull(
          linked: () {
            final schoolName = _selectedInstitution?.name ?? 'your school';
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Linked to $schoolName'),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                ),
              );
            widget.onNext();
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                const ProfileStepHeading(
                  icon: Icons.school_outlined,
                  title: 'Find your campus',
                  subtitle: 'Link your school to see the services and community relevant to you.',
                ),
                const SizedBox(height: 30),
                SearchAnchor.bar(
                  searchController: _searchController,
                  barElevation: const WidgetStatePropertyAll(0),
                  barBackgroundColor: WidgetStatePropertyAll(
                    colors.surfaceContainerLow,
                  ),
                  barShape: const WidgetStatePropertyAll(StadiumBorder()),
                  barHintText: 'Search schools and universities',
                  barLeading: const Icon(Icons.search_rounded),
                  viewElevation: 2,
                  viewShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  suggestionsBuilder: (context, controller) {
                    final query = controller.text.trim();
                    if (query.isEmpty) return const [];

                    context.read<InstitutionBloc>().add(
                      SearchInstitutionByNameEvent(query),
                    );

                    return [
                      BlocBuilder<InstitutionBloc, InstitutionState>(
                        builder: (context, state) => state.maybeWhen(
                          loading: () => const Padding(
                            padding: EdgeInsets.all(28),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                          error: (message) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              message,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          loaded: (institutions) {
                            if (institutions.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 32,
                                      color: colors.onSurfaceVariant,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('No schools found'),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Try another name or search term.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: colors.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Column(
                              children: institutions.map((institution) {
                                final domain = institution.domains?.firstOrNull;
                                return ListTile(
                                  minVerticalPadding: 12,
                                  leading: CircleAvatar(
                                    backgroundColor: colors.secondaryContainer,
                                    foregroundColor:
                                        colors.onSecondaryContainer,
                                    child: const Icon(Icons.school_rounded),
                                  ),
                                  title: Text(institution.name),
                                  subtitle: Text(
                                    domain == null || domain.isEmpty
                                        ? 'Institution'
                                        : domain,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                  ),
                                  onTap: () {
                                    setState(
                                      () => _selectedInstitution = institution,
                                    );
                                    controller.closeView(institution.name);
                                  },
                                );
                              }).toList(),
                            );
                          },
                          orElse: () => const SizedBox.shrink(),
                        ),
                      ),
                    ];
                  },
                ),
                if (_selectedInstitution case final institution?) ...[
                  const SizedBox(height: 18),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: colors.onPrimaryContainer,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected campus',
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: colors.onPrimaryContainer,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  institution.name,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: colors.onPrimaryContainer,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: 'Choose a different school',
                            onPressed: () =>
                                setState(() => _selectedInstitution = null),
                            color: colors.onPrimaryContainer,
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 20,
                      color: colors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'You can still use Academia without linking a school. Add one later from your profile.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton.icon(
                onPressed: widget.onPrevious,
                style: TextButton.styleFrom(
                  minimumSize: const Size(72, 52),
                  foregroundColor: colors.onSurfaceVariant,
                ),
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: const Text('Back'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: widget.onNext,
                style: TextButton.styleFrom(minimumSize: const Size(64, 52)),
                child: const Text('Skip'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _selectedInstitution == null || _profile == null
                      ? null
                      : _confirmLink,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: const StadiumBorder(),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: const Text('Link school'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLink() async {
    final institution = _selectedInstitution;
    final profile = _profile;
    if (institution == null || profile == null) return;

    final shouldLink = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) {
        final colors = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.school_rounded, size: 32, color: colors.primary),
              const SizedBox(height: 16),
              Text(
                'Link ${institution.name}?',
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Confirm that you’re a member of this school. Some details may be verified to provide campus services.',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: colors.onSurfaceVariant, height: 1.4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Confirm school'),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Choose another'),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || shouldLink != true) return;
    context.read<InstitutionBloc>().add(
      LinkAccountToInstitutionEvent(
        accountID: profile.id,
        institutionID: institution.institutionId,
      ),
    );
  }
}
