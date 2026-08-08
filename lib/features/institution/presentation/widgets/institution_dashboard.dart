import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magnet/magnet.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

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
          listener: (context, state) {},
        ),
        BlocListener<StudentProfileBloc, StudentProfileState>(
          listener: (context, state) {},
        ),
        BlocListener<MagnetBloc, MagnetState>(
          listener: (context, state) {
            state.maybeWhen(
              processing: (command, progress) =>
                  setState(() => _showSyncCard = false),
              initializing: () => setState(() => _showSyncCard = false),
              error: (message) => setState(() => _showSyncCard = true),
              initial: () => setState(() => _showSyncCard = true),
              orElse: () {},
            );
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
              ...state.maybeWhen(
                processing: (command, progress) => [
                  Column(
                    children: [
                      LoadingIndicatorM3E(),
                      SizedBox(height: 16),
                      Text(progress?.instructionType ?? "Crunching numbers"),
                    ],
                  ),
                ],
                orElse: () => const <Widget>[],
              ),
              ...state.maybeWhen(
                success: (result) => [
                  Column(
                    children: [
                      Image.memory(
                        result.data["post_click_screenshot"],
                        height: 500,
                        width: 500,
                      ),
                      Image.memory(
                        result.data["post_dashboard_screenshot"],
                        height: 500,
                        width: 500,
                      ),
                    ],
                  ),
                ],
                orElse: () => const <Widget>[],
              ),
              FilledButton(
                onPressed: () {
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
