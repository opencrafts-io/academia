import 'package:academia/config/router/router.dart';
import 'package:flutter/material.dart';

class InstitutionFeesSectionCard extends StatelessWidget {
  const InstitutionFeesSectionCard({super.key, required this.institutionID});

  final int institutionID;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: ListTile(
        onTap: () {
          InstitutionFeesTransactionRoute(
            institutionID: institutionID,
          ).push(context);
        },
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          child: Icon(
            Icons.account_balance_rounded,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        title: Text("Fees transactions"),
        subtitle: Text("View your fees transactions"),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }
}
