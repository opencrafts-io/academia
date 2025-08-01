import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreateTodoBottomSheet extends StatefulWidget {
  const CreateTodoBottomSheet({super.key, this.parentTodo});
  final String? parentTodo;

  @override
  State<CreateTodoBottomSheet> createState() => _CreateTodoBottomSheetState();
}

class _CreateTodoBottomSheetState extends State<CreateTodoBottomSheet> {
  bool showDescription = false;
  bool showTime = true;

  final TextEditingController _titleController = TextEditingController(
    text: "",
  );
  final TextEditingController _descriptionController = TextEditingController(
    text: "",
  );
  DateTime? due;

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
    return Container(
      constraints: BoxConstraints(minHeight: 120, maxHeight: 240),
      padding: EdgeInsets.all(12),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            TextFormField(
              controller: _titleController,
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                hintText: "New task",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            Visibility(
              visible: due != null,
              child: Chip(
                deleteIcon: Icon(Icons.close),
                label: Text(
                  due == null
                      ? "Pick date"
                      : DateFormat('EEE, dd MMM').format(due!),
                ),
                onDeleted: () {
                  setState(() {
                    due = null;
                  });
                },
              ),
            ),
            Visibility(
              visible: showDescription,
              child: TextFormField(
                controller: _descriptionController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Add details",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Visibility(
                  visible: !showDescription,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showDescription = !showDescription;
                      });
                    },
                    icon: Icon(Icons.short_text),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    due = await showDateTimePicker(context: context);
                    setState(() {});
                  },
                  icon: Icon(Icons.schedule),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    final state = BlocProvider.of<ProfileBloc>(context).state;
                    if (state is! ProfileLoadedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "We cant create your todo at the moment",
                          ),
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
                      AddTodoEvent(
                        todo: Todo(
                          deleted: false,
                          etag: "",
                          hidden: false,
                          id: "",
                          kind: "",
                          owner: state.profile.id,
                          position: "",
                          selfLink: "",
                          status: "",
                          title: _titleController.text,
                          webViewLink: "",
                          due: due?? DateTime.now(),
                          notes: _descriptionController.text,
                          parent: widget.parentTodo,
                        ),
                      ),
                    );

                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          spacing: 8,
                          children: [
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator.adaptive(),
                            ),
                            Text("Creating your todo"),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
