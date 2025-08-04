import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    isComplete = widget.todo.status != "needsAction";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todo.id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.tertiary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [const Icon(Icons.check)],
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error, // A color for deletion
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete_forever),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          BlocProvider.of<TodoBloc>(
            context,
          ).add(CompleteTodoEvent(todo: widget.todo));
        } else if (direction == DismissDirection.endToStart) {
          BlocProvider.of<TodoBloc>(
            context,
          ).add(DeleteTodoEvent(todo: widget.todo));
        }
      },

      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
          elevation: 2,
          margin: EdgeInsets.zero,
          child: CheckboxListTile.adaptive(
            checkboxShape: CircleBorder(side: BorderSide()),
            value: isComplete,
            onChanged: (val) {
              setState(() {
                isComplete = !isComplete;
              });
              BlocProvider.of<TodoBloc>(
                context,
              ).add(CompleteTodoEvent(todo: widget.todo));
            },
            title: Text(widget.todo.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todo.notes ?? '',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Chip(
                  avatar: Icon(Icons.alarm),
                  label: Text(
                    widget.todo.due == null
                        ? "Indeterminate"
                        : DateFormat(
                            'EEE, dd MMM yyyy',
                          ).format(widget.todo.due!),
                  ),
                ),

                // widget.todo.due!.isAfter(DateTime.now())
                //     ? Text(timeSince(widget.todo.due))
                //     : Text(timeSince(widget.todo.due)),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
