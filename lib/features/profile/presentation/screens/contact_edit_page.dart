import 'package:flutter/material.dart';

class ContactEditPage extends StatefulWidget {
  const ContactEditPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<ContactEditPage> createState() => _ContactEditPageState();
}

class _ContactEditPageState extends State<ContactEditPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        SizedBox(height: 12),
        Text(
          "How can we reach you",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        TextFormField(
          decoration: InputDecoration(
            label: Text("Your phone number"),
            hintText: "+254 712345678",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        SizedBox(height: 12),

        ListTile(
          isThreeLine: true,
          leading: Icon(Icons.info),
          title: Text("About your phone number"),
          subtitle: Text(
            "Some services in the application require your phone number ",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),

        Row(
          spacing: 12,
          children: [
            OutlinedButton(
              onPressed: widget.onPrevious,
              child: Text("Previous"),
            ),
            FilledButton(onPressed: widget.onNext, child: Text("Next")),
          ],
        ),
      ],
    );
  }
}
