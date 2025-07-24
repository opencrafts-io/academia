import 'package:flutter/material.dart';

class SchoolEditPage extends StatefulWidget {
  const SchoolEditPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<SchoolEditPage> createState() => _SchoolEditPageState();
}

class _SchoolEditPageState extends State<SchoolEditPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        SizedBox(height: 12),
        Text(
          "Which school are you from?",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        TextFormField(
          decoration: InputDecoration(
            label: Text("Your school"),
            hintText: "Hogwart's ",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        ListTile(
          isThreeLine: true,
          leading: Icon(Icons.info),
          title: Text("Why is my school information important"),
          subtitle: Text(
            "Some services in the application require to know where you're from to work",
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
