import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TodoViewSheet extends StatefulWidget {
  const TodoViewSheet({super.key, this.parentTodo, required this.todo});
  final Todo todo;

  final String? parentTodo;

  @override
  State<TodoViewSheet> createState() => _TodoViewSheetState();
}

class _TodoViewSheetState extends State<TodoViewSheet> {
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.notes ?? '';
    due = widget.todo.due;
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? due;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actionsPadding: EdgeInsets.only(right: 12),
        actions: [
          FilledButton(
            onPressed: () {
              final state = BlocProvider.of<ProfileBloc>(context).state;
              if (state is! ProfileLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("We cant create your todo at the moment"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              if (_titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Todo title cannot be empty"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              BlocProvider.of<TodoBloc>(context).add(
                UpdateTodoEvent(
                  todo: widget.todo.copyWith(
                    title: _titleController.text,
                    notes: _descriptionController.text,
                    due: due,
                    updated: DateTime.now(),
                  ),
                ),
              );

              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    spacing: 8,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      Text("Updating todo ..."),
                    ],
                  ),
                ),
              );
            },
            child: Text("Update To-Do"),
          ),
        ],
      ),

      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            TextFormField(
              maxLines: null,
              minLines: 1,
              controller: _titleController,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Add a title",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text(
                DateFormat(
                  'EEE, dd MMMM',
                ).format(due ?? DateTime.now().add(Duration(hours: 1))),
              ),
              onTap: () async {
                final newDue = await showDateTimePicker(
                  context: context,
                  firstDate: DateTime.now(),
                );
                if (!mounted) return;
                setState(() {
                  due = newDue;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.attachment),
              title: Text("Add attachments"),
              onTap: () {},
            ),
            TextFormField(
              controller: _descriptionController,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: null,
              minLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Add a note",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),

            Divider(),
            ListTile(leading: Icon(Icons.checklist), title: Text("Subtasks")),
            TextButton.icon(
              onPressed: () {},
              label: Text("Add subtask"),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
