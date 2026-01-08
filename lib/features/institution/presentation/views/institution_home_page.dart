import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: CustomScrollView(
        slivers: [
          BlocBuilder<InstitutionBloc, InstitutionState>(
            builder: (context, state) => SliverAppBar.large(
              title: Text(
                state is InstitutionLoadedState
                    ? state.institutions
                          .firstWhere(
                            (ins) => ins.institutionId == widget.institutionID,
                          )
                          .name
                    : "#Error",
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
