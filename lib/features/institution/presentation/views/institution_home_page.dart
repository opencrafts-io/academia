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
    return BlocProvider(
      create: (context) => sl<ScrappingCommandBloc>()
        ..add(GetScrappingCommandEvent(institutionID: widget.institutionID)),
      child: Scaffold(
        body: BlocConsumer<ScrappingCommandBloc, ScrappingCommandState>(
          listener: (context, state) {
            if (state is ScrappingCommandLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoadingIndicatorM3E(
                        constraints: BoxConstraints(
                          maxHeight: 10,
                          minWidth: 10,
                        ),
                      ),
                      SizedBox(width: 16),
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

          builder: (context, commandState) => CustomScrollView(
            slivers: [
              BlocBuilder<InstitutionBloc, InstitutionState>(
                builder: (context, state) => SliverAppBar.large(
                  title: Text(
                    state is InstitutionLoadedState
                        ? state.institutions
                              .firstWhere(
                                (ins) =>
                                    ins.institutionId == widget.institutionID,
                              )
                              .name
                        : "#Error",
                  ),
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                  ],
                ),
              ),

              if (commandState is ScrappingCommandLoaded &&
                  commandState.command == null)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/illustrations/joe-error.png",
                          height: 500,
                          width: 500,
                        ),
                        Text(
                          "Oops!",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.left,
                        ),

                        Text(
                          "We couldn't load your school's setup. "
                          "This usually happens due to a poor connection "
                          "or if your institution isn't fully supported yet.",
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
