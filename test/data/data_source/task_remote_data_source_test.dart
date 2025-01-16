import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:task_manager/features/task/data/data_sources/task_remote_data_source.dart';
import 'package:task_manager/features/task/data/model/task_model.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late TaskRemoteDataSource taskRemoteDataSource;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.options.baseUrl = 'https://dummyjson.com';
    dio.httpClientAdapter = dioAdapter;

    taskRemoteDataSource = TaskRemoteDataSource(dio: dio);
  });

  group('TaskRemoteDataSource', () {
    const fetchTasksEndpoint = '/todos';
    const addTaskEndpoint = '/todos/add';
    const deleteTaskEndpoint = '/todos/1';
    const updateTaskEndpoint = '/todos/1';

    test('fetchTasks should return a list of tasks', () async {
      final mockResponse = {
        'todos': [
          {'id': 1, 'todo': 'Test Task', 'completed': false},
        ],
      };

      dioAdapter.onGet(
          fetchTasksEndpoint, (server) => server.reply(200, mockResponse));

      final result = await taskRemoteDataSource.fetchTasks();

      expect(result, isA<List<TaskModel>>());
      expect(result.first.title, 'Test Task');
    });

    test('addTask should return the created task', () async {
      final mockResponse = {'id': 1, 'todo': 'New Task', 'completed': false};
      final task = TaskModel(id: 0, title: 'New Task', completed: false);

      dioAdapter.onPost(
          addTaskEndpoint,
          data: {
            'todo': task.title,
            'completed': task.completed,
            'userId': 5,
          },
          (server) => server.reply(200, mockResponse));

      final result = await taskRemoteDataSource.addTask(task);

      expect(result, isA<TaskModel>());
      expect(result.title, 'New Task');
    });

    test('updateTask should return the updated task', () async {
      final mockResponse = {'id': 1, 'todo': 'Updated Task', 'completed': true};
      final task = TaskModel(id: 1, title: 'Updated Task', completed: true);

      dioAdapter.onPut(
          updateTaskEndpoint,
          data: {
            'todo': task.title,
            'completed': task.completed,
            'userId': task.id,
          },
          (server) => server.reply(200, mockResponse));

      final result = await taskRemoteDataSource.updateTask(task);

      expect(result, isA<TaskModel>());
      expect(result.title, 'Updated Task');
    });

    test('deleteTask should complete without throwing an exception', () async {
      dioAdapter.onDelete(
          deleteTaskEndpoint, (server) => server.reply(200, {}));

      expect(() => taskRemoteDataSource.deleteTask(1), completes);
    });
  });
}
