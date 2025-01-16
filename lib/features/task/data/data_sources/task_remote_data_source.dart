import 'package:dio/dio.dart';
import 'package:task_manager/features/task/data/model/task_model.dart';

class TaskRemoteDataSource {
  final Dio _dio = Dio();

  TaskRemoteDataSource() {
    _dio.options.baseUrl = 'https://dummyjson.com';
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<List<TaskModel>> fetchTasks({int limit = 10, int skip = 0}) async {
    try {
      final response = await _dio.get(
        '/todos',
        queryParameters: {'limit': limit, 'skip': skip},
      );
      return (response.data['todos'] as List)
          .map((task) => TaskModel.fromJson(task))
          .toList();
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }

  Future<TaskModel> addTask(TaskModel task) async {
    try {
      final response = await _dio.post(
        '/todos/add',
        data: {
          'todo': task.title,
          'completed': task.completed,
          'userId': 5,
        },
      );
      return TaskModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      final response = await _dio.put(
        '/todos/${task.id}',
        data: {
          'todo': task.title,
          'completed': task.completed,
          'userId': task.id,
        },
      );
      return TaskModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _dio.delete('/todos/$id');
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }
}
