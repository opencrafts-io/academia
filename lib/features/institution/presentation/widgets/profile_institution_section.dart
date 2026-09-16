import 'package:academia/core/clippers/clippers.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInstitutionSection extends StatelessWidget {
  const ProfileInstitutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstitutionBloc, InstitutionState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (institutions) {
            if (institutions.isEmpty) {
              return SizedBox();
            }
            return Text(institutions.first.name);
          },
          error: (error) => Text(error),
          orElse: () => Padding(
            padding: EdgeInsets.all(12),
            child: SpinningScallopIndicator(),
          ),
        );
      },
    );
  }
}
