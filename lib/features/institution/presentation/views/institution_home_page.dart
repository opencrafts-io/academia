import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionHomePage extends StatefulWidget {
  const InstitutionHomePage({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<InstitutionHomePage> createState() => _InstitutionHomePageState();
}

class _InstitutionHomePageState extends State<InstitutionHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ScrappingCommandBloc, ScrappingCommandState>(
        listener: (context, state) {
          if (state is ScrappingCommandLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingIndicatorM3E(
                      constraints: BoxConstraints(maxHeight: 10, minWidth: 10),
                    ),
                    SizedBox(width: 18),
                    Text("Fetching institution configurations"),
                  ],
                ),
                duration: Duration(seconds: 10),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is ScrappingCommandLoaded) {
            ScaffoldMessenger.of(context).clearSnackBars();
          } else if (state is ScrappingCommandError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: Duration(seconds: 20),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },

        builder: (context, commandState) => RefreshIndicator.adaptive(
          onRefresh: () async {
            BlocProvider.of<ScrappingCommandBloc>(context).add(
              GetScrappingCommandEvent(institutionID: widget.institutionID),
            );
            await Future.delayed(Duration(seconds: 2));
          },
          child: CustomScrollView(
            slivers: [
              _InstitutionHomePageAppBar(institutionID: widget.institutionID),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstitutionHomePageAppBar extends StatelessWidget {
  const _InstitutionHomePageAppBar({required this.institutionID});
  final int institutionID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) => SliverAppBar.large(
        title: Text(
          state is InstitutionLoadedState
              ? state.institutions
                    .firstWhere((ins) => ins.institutionId == institutionID)
                    .name
              : "#Error",
        ),
        actions: [
          BlocBuilder<ScrappingCommandBloc, ScrappingCommandState>(
            builder: (context, state) => state is ScrappingCommandLoaded
                ? IconButton(
                    onPressed: () {
                      InstitutionKeysViewRoute(
                        institutionID: institutionID,
                      ).push(context);
                    },
                    icon: Icon(Icons.key_outlined),
                  )
                : LoadingIndicatorM3E(),
          ),
        ],
      ),
    );
  }
}
