import 'package:academia/config/router/router.dart';
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
              return Card.outlined(
                child: ListTile(
                  title: Text(ins.name),
                  subtitle: Text("Tap to view & manage your profile"),
                  trailing: Icon(Icons.open_in_new),
                  onTap: () {
                  MagnetAuthRoute(institutionID: ins.institutionId).push(context);
                  },
                ),
              );
            },
          );
        } else if (state is InstitutionErrorState) {
          return Text(state.error);
        }

        return LinearProgressIndicator();
      },
    );
  }
}
