import 'package:flutter/material.dart';

class NameEditPage extends StatefulWidget {
  const NameEditPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<NameEditPage> createState() => _NameEditPageState();
}

class _NameEditPageState extends State<NameEditPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        SizedBox(height: 12),
        Text(
          "Lets get to know you by name",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        TextFormField(
          decoration: InputDecoration(
            label: Text("Your names"),
            hintText: "Arnold Schwarzenegger",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        TextFormField(
          decoration: InputDecoration(
            label: Text("Your nickname"),
            hintText: "Schwarzenegger",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        ListTile(
          isThreeLine: true,
          leading: Icon(Icons.info),
          title: Text("About nicknames"),
          subtitle: Text(
            "Nicknames are like usernames in the app. We'll only show them to your friends",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),

        Row(
          spacing: 12,
          children: [
            OutlinedButton(onPressed: widget.onPrevious, child: Text("Previous")),
            FilledButton(onPressed: widget.onNext, child: Text("Next")),
          ],
        ),
      ],
    );
  }
}
