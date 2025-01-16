import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/domain/entities/task_entity.dart';
import 'package:task_manager/features/task/presentaion/bloc/task_bloc.dart';
import 'package:task_manager/features/task/presentaion/bloc/task_event.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController taskController;

  AddTaskDialog({Key? key, required this.taskController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: TextField(
        controller: taskController,
        decoration: const InputDecoration(hintText: "Enter task title"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final newTask = TaskEntity(
              id: DateTime.now().millisecondsSinceEpoch,
              title: taskController.text.trim(),
              completed: false,
            );
            BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(newTask));
            taskController.clear();
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
