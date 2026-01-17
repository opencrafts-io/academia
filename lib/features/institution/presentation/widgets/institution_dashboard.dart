import 'package:flutter/material.dart';

class InstitutionDashboard extends StatelessWidget {
  const InstitutionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [InstitutionProfileCard()]);
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
