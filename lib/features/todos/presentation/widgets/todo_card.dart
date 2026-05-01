import 'package:academia/features/todos/presensentation/widgets/todo_view_sheet.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:time_since/time_since.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({
    super.key,
    required this.todo,
    this.borderRadius = BorderRadius.zero,
  });
  final Todo todo;
  final BorderRadius borderRadius;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isComplete = false;

  String truncateWithEllipsis(String text, {int maxLength = 120}) {
    if (text.length <= maxLength) return text;
    return "${text.substring(0, maxLength - 3)}...";
  }

  @override
  void initState() {
    isComplete = widget.todo.status != "needsAction";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.todo.id),
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              BlocProvider.of<TodoBloc>(
                context,
              ).add(DeleteTodoEvent(todo: widget.todo));
            },
            icon: Icons.delete,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            label: "Delete todo",
          ),
          SlidableAction(
            onPressed: (_) {
              BlocProvider.of<TodoBloc>(
                context,
              ).add(CompleteTodoEvent(todo: widget.todo));
            },

            label: "Complete todo",
            icon: Icons.check,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ],
      ),
      child: InkWell(
        onDoubleTap: () {
          showModalBottomSheet(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (context) => TodoViewSheet(todo: widget.todo),
          );
        },
        child: CheckboxListTile(
          dense: false,
          contentPadding: EdgeInsets.zero,
          internalAddSemanticForOnTap: true,
          onChanged: (value) {
            BlocProvider.of<TodoBloc>(
              context,
            ).add(CompleteTodoEvent(todo: widget.todo));

            setState(() {
              isComplete = value!;
            });
          },
          checkboxShape: CircleBorder(),
          value: isComplete,
          title: Text(
            truncateWithEllipsis(widget.todo.title, maxLength: 60),
            style: isComplete
                ? TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                truncateWithEllipsis(widget.todo.notes ?? ''),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodySmall,
              ),

              Row(
                children: [
                  Icon(Icons.timer_outlined, size: 18),
                  SizedBox(width: 4),
                  if (widget.todo.due?.isAfter(DateTime.now()) ?? false)
                    Text(
                      widget.todo.due == null
                          ? "Indeterminate"
                          : DateFormat(
                              'EEE, dd MMM yyyy HH:mm',
                            ).format(widget.todo.due!),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  if (widget.todo.due?.isBefore(DateTime.now()) ?? false)
                    Text(
                      timeSince(widget.todo.due!),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              ),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
