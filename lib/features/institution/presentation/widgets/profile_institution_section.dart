import 'package:academia/config/router/router.dart';
import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/institution/institution.dart';
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
          return Text(state.institutions.first.name);
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
