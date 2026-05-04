import 'package:academia/core/core.dart';
import 'package:academia/features/todos/todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class CreateTodoListScreen extends StatefulWidget {
  const CreateTodoListScreen({super.key});

  @override
  State<CreateTodoListScreen> createState() => _CreateTodoListScreenState();
}

class _CreateTodoListScreenState extends State<CreateTodoListScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  Color taskListColor = const Color(0xFF0061A4);
  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: AppBar(
        title: Text("Create new list"),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newTodoList = TodoListEntity(
                  localId: 0,
                  title: titleController.text.trim(),
                  isDefault: false,
                  syncStatus: SyncStatus.pending,
                  taskCount: 0,
                  isPendingDeletion: false,
                  color: taskListColor.toARGB32(),
                );
                context.read<TodoListCubit>().createTodoList(newTodoList);

                context.pop();
              }
            },
            child: Text("Done"),
          ),
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.0,
                  color: taskListColor,
                ),
                cursorHeight: 32,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                validator: (input) {
                  if ((input?.length ?? 0) < 3) {
                    return "Please try a longer title";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Homework",
                  hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: taskListColor.withAlpha(128),
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),

              SizedBox(height: 22),
              Text("Please pick a color for this task list"),
              SizedBox(height: 22),
              ColorSeedCard(
                currentColor: taskListColor,
                onColorChanged: (color) {
                  setState(() {
                    taskListColor = color;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
