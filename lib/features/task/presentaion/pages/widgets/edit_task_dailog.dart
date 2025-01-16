import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/domain/entities/task_entity.dart';
import 'package:task_manager/features/task/presentaion/bloc/task_bloc.dart';
import 'package:task_manager/features/task/presentaion/bloc/task_event.dart';

class EditTaskDialog extends StatelessWidget {
  final TextEditingController taskController;
  final TaskEntity task;

  const EditTaskDialog(
      {Key? key, required this.taskController, required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    taskController.text = task.title;

    return AlertDialog(
      title: const Text("Edit Task"),
      content: TextField(
        controller: taskController,
        decoration: const InputDecoration(hintText: "Edit task title"),
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
            final updatedTask = TaskEntity(
              id: task.id,
              title: taskController.text.trim(),
              completed: task.completed,
            );
            BlocProvider.of<TaskBloc>(context)
                .add(UpdateTaskEvent(updatedTask));
            taskController.clear();
            Navigator.of(context).pop();
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}
