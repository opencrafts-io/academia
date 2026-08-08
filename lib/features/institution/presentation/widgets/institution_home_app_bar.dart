import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionHomeAppBar extends StatelessWidget {
  const InstitutionHomeAppBar({super.key, required this.institutionID});

  final int institutionID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) => SliverAppBar.large(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          state.maybeWhen(
            loaded: (institutions) => institutions
                .firstWhere((ins) => ins.institutionId == institutionID)
                .name,
            orElse: () => "#Error",
          ),
        ),
        actions: [
          BlocBuilder<ScrappingCommandBloc, ScrappingCommandState>(
            builder: (context, state) => state.maybeWhen(
              loaded: (command) => IconButton(
                onPressed: () {
                  InstitutionKeysViewRoute(
                    institutionID: institutionID,
                  ).push(context);
                },
                icon: Icon(Icons.key_rounded),
              ),
              orElse: () => const SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: LoadingIndicatorM3E(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
