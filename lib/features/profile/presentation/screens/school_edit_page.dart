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

        SizedBox(height: 22),

        SearchAnchor.bar(
          barElevation: WidgetStatePropertyAll(0),
          barShape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          barHintText: "Hogwart's School of Wizardry",
          barLeading: Icon(Icons.search),
          viewElevation: 0,
          suggestionsBuilder: (context, searchController) async {
            return [
              ListTile(
                title: Text("Daystar University"),
                subtitle: Text("daystar.ac.ke"),
                trailing: Text("KE"),
              ),
            ];
          },
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
