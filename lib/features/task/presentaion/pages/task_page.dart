import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../../domain/entities/task_entity.dart';

class TaskPage extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      BlocProvider.of<TaskBloc>(context)
          .add(LoadTasksEvent(limit: 10, skip: 0));
    });
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadedState) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(task.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _taskController.text = task.title;
                            _showEditTaskDialog(context, task);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            BlocProvider.of<TaskBloc>(context)
                                .add(DeleteTaskEvent(task.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is TaskErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No tasks available."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: "Enter task title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newTask = TaskEntity(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: _taskController.text.trim(),
                  completed: false,
                );
                BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(newTask));
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, TaskEntity task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: "Edit task title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTask = TaskEntity(
                  id: task.id,
                  title: _taskController.text.trim(),
                  completed: task.completed,
                );
                BlocProvider.of<TaskBloc>(context)
                    .add(UpdateTaskEvent(updatedTask));
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
