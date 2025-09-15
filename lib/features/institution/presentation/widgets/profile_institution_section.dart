import 'package:academia/config/router/router.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/magnet/presentation/bloc/magnet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInstitutionSection extends StatelessWidget {
  const ProfileInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstitutionBloc, InstitutionState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is InstitutionLoadedState) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.institutions.length,
            itemBuilder: (context, index) {
              if (state.institutions.isEmpty) {
                return Text("Please refresh to fetch your institutions");
              }
              final ins = state.institutions[index];

              final isInstitutionSupported = context
                  .read<MagnetBloc>()
                  .isInstitutionSupported(ins.institutionId);

              return Card.outlined(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  title: Text(ins.name),
                  subtitle: Text("Tap to view & manage your profile"),
                  trailing: Icon(Icons.open_in_new),
                  onTap: isInstitutionSupported
                      ? () {
                          MagnetAuthRoute(
                            institutionID: ins.institutionId,
                          ).push(context);
                        }
                      : () {
                          showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            showDragHandle: true,
                            isScrollControlled: true,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surface,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.school_outlined,
                                      size: 48,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "${ins.name} is not supported (yet)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Your institution isn’t supported on Academia yet."
                                      "We’d love to bring your community on board! 🚀\n\n"
                                      "If you’re a student, staff member, or developer from your "
                                      "institution, just drop us a message — our team will work with "
                                      "you to make it happen.\n\n"
                                      "Together, we can unlock all the features of Academia for your "
                                      "institution. 💚\n\n"
                                      "— With love,\n"
                                      "The Academia Developers 💫",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 24),
                                    FilledButton.icon(
                                      icon: const Icon(Icons.email_outlined),
                                      label: const Text("Contact Us"),
                                      onPressed: () async {
                                        final uri = Uri(
                                          scheme: 'mailto',
                                          path: 'developers@opencrafts.io',
                                          queryParameters: {
                                            'subject':
                                                'Institution Support Request for ${ins.name}',
                                            'body':
                                                'Hello Academia team,\n\nI would like to request support for ${ins.name}.',
                                          },
                                        );

                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          if (!context.mounted) return;
                                          context.pop();
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Could not launch email app",
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    TextButton(
                                      child: const Text("Close"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                ),
              );
            },
          );
        } else if (state is InstitutionErrorState) {
          return Text(state.error);
        }

        return Padding(
          padding: EdgeInsets.all(12),
          child: SpinningScallopIndicator(),
        );
      },
    );
  }
}
