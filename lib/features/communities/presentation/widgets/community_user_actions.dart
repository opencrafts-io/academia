import 'package:flutter/material.dart';

/// A reusable function to show user actions modal.
///
/// [name] - the user's display name
/// [isModerator] - whether the user is a moderator (hides "promote/ban/remove")
Future<void> showUserActionsSheet(
  BuildContext context,
  String name, {
  bool isModerator = false,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ User header
            ListTile(
              leading: CircleAvatar(child: Text(name[0].toUpperCase())),
              title: Text(name, style: Theme.of(context).textTheme.titleMedium),
            ),
            const Divider(),

            // Always available
            ListTile(
              leading: const Icon(Icons.message),
              title: Text("Message $name"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Messaging $name...")));
              },
            ),

            // Extra actions for members
            if (!isModerator) ...[
              ListTile(
                leading: const Icon(Icons.shield_moon),
                title: Text("Make $name moderator"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$name is now a moderator")),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.block, color: Colors.red),
                title: Text("Ban $name"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$name has been banned")),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_remove, color: Colors.orange),
                title: Text("Remove $name"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$name has been removed")),
                  );
                },
              ),
            ],
          ],
        ),
      );
    },
  );
}
