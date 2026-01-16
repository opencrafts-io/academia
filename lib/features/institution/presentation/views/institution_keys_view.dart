import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionKeysView extends StatefulWidget {
  const InstitutionKeysView({super.key});

  @override
  State<InstitutionKeysView> createState() => _InstitutionKeysViewState();
}

class _InstitutionKeysViewState extends State<InstitutionKeysView> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              title: Text("Discard changes?"),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                  },
                  child: const Text("Discard"),
                ),
              ],
            ),
          );
        }
      },
      child: BlocProvider.value(
        value: context.read<ScrappingCommandBloc>(),
        child: SheetContentScaffold(
          topBar: AppBar(centerTitle: true, title: Text("Keys management")),
          body: SafeArea(
            child: BlocBuilder<ScrappingCommandBloc, ScrappingCommandState>(
              builder: (context, state) {
                if (state is ScrappingCommandLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoadingIndicatorM3E(),
                      SizedBox(height: 12),
                      Text("Loading institution information"),
                    ],
                  );
                } else if (state is ScrappingCommandError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Holy molly ..."),
                      SizedBox(height: 12),
                      Text(state.message),
                    ],
                  );
                } else if (state is ScrappingCommandInitial) {
                  return SizedBox.shrink();
                }

                return Center(
                  child: FilledButton(
                    onPressed: () => context.pop(),
                    child: Text("BACK"),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
