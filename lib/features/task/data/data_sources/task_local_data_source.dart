import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/task/data/model/task_model.dart';

class TaskLocalDataSource {
  final SharedPreferences? sharedPreferences;

  TaskLocalDataSource({this.sharedPreferences});

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    await sharedPreferences?.setString('tasks', tasksJson.toString());
  }

  Future<List<TaskModel>> fetchTasks() async {
    final tasksJsonString = sharedPreferences?.getString('tasks');
    if (tasksJsonString != null) {
      final List<dynamic> tasksJson = List<dynamic>.from(
        (await Future.value(tasksJsonString)).split(','),
      );
      final tasks = tasksJson.map((task) => TaskModel.fromJson(task)).toList();
      return tasks;
    }
    return [];
  }
}
