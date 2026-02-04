import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import './sync_required_card.dart';

class InstitutionDashboard extends StatefulWidget {
  const InstitutionDashboard({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<InstitutionDashboard> createState() => _InstitutionDashboardState();
}

class _InstitutionDashboardState extends State<InstitutionDashboard> {
  bool _showSyncCard = true;
  @override
  void initState() {
    super.initState();
    context.read<MagnetBloc>().add(
      InitializeMagnet(MagnetConfig.production(schemaServerUrl: "")),
    );
    //
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<StudentProfileBloc>().add(
        WatchProfileByUserAndInstitutionEvent(
          userID: profileState.profile.id,
          institutionID: widget.institutionID,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ScrappingCommandBloc, ScrappingCommandState>(
          listener: (context, state) {
            if (state is ScrappingCommandLoaded) {}
          },
        ),
        BlocListener<StudentProfileBloc, StudentProfileState>(
          listener: (context, state) {},
        ),
        BlocListener<MagnetBloc, MagnetState>(
          listener: (context, state) {
            if (state is MagnetProcessing || state is MagnetInitializing) {
              setState(() {
                _showSyncCard = false;
              });
            } else if (state is MagnetError || state is MagnetInitial) {
              setState(() {
                _showSyncCard = true;
              });
            }
          },
        ),
      ],
      child: BlocBuilder<MagnetBloc, MagnetState>(
        builder: (context, state) {
          return Column(
            children: [
              if (_showSyncCard)
                SyncRequiredCard(
                  onSyncPressed: () {},
                  onDismiss: () => setState(() {
                    _showSyncCard = false;
                  }),
                ),
              Text(state.runtimeType.toString()),
              if (state is MagnetProcessing)
                Column(
                  children: [
                    LoadingIndicatorM3E(),
                    SizedBox(height: 16),
                    Text(
                      state.progress?.instructionType ?? "Crunching numbers",
                    ),
                  ],
                ),
              if (state is MagnetSuccess)
                Column(
                  children: [
                    Image.memory(
                      state.result.data["post_click_screenshot"],
                      height: 500,
                      width: 500,
                    ),
                    Image.memory(
                      state.result.data["post_dashboard_screenshot"],
                      height: 500,
                      width: 500,
                    ),
                  ],
                ),
              FilledButton(
                onPressed: () {
                  // final scrappingCommandState = context
                  //     .read<ScrappingCommandBloc>()
                  //     .state;
                  // final magnetState = context.read<MagnetBloc>().state;
                  // final institutionKeyState = context
                  //     .read<InstitutionKeyBloc>()
                  //     .state;

                  // if ((magnetState is MagnetReady ||
                  //         magnetState is MagnetSuccess) &&
                  //     scrappingCommandState is ScrappingCommandLoaded &&
                  //     institutionKeyState is InstitutionKeyLoaded) {
                  //   context.read<MagnetBloc>().add(
                  //     ExecuteScrappingCommand(
                  //       command: scrappingCommandState.command!,
                  //       institutionKey: institutionKeyState.key!,
                  //     ),
                  //   );
                  //   return;
                  // }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Institution not supported"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text("Hello"),
              ),
            ],
          );
        },
      ),
    );
  }
}

class InstitutionProfileCard extends StatelessWidget {
  const InstitutionProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: ListTile(
        trailing: Icon(Icons.open_in_new),
        title: Text("John Doe"),
        subtitle: Text("Student"),
      ),
    );
  }
}
