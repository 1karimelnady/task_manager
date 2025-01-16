import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/task/data/model/task_model.dart';

class TaskLocalDataSource {
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    prefs.setString('tasks', tasksJson.toString());
  }

  Future<List<TaskModel>> fetchTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final tasks =
          (tasksJson as List).map((task) => TaskModel.fromJson(task)).toList();
      return tasks;
    }
    return [];
  }
}
