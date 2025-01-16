import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/task/data/data_sources/task_local_data_source.dart';
import 'package:task_manager/features/task/data/model/task_model.dart';

import 'task_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late TaskLocalDataSource taskLocalDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    taskLocalDataSource =
        TaskLocalDataSource(sharedPreferences: mockSharedPreferences);
  });

  group('TaskLocalDataSource', () {
    final task = TaskModel(id: 1, title: 'Test Task', completed: false);
    final taskList = [task];
    final taskJsonList = '[{"id":1,"title":"Test Task","completed":false}]';

    test('saveTasks should save a list of tasks in SharedPreferences',
        () async {
      when(mockSharedPreferences.setString('tasks', taskJsonList))
          .thenAnswer((_) async => true);

      await taskLocalDataSource.saveTasks(taskList);

      verify(mockSharedPreferences.setString('tasks', taskJsonList)).called(1);
    });

    test('fetchTasks should return a list of tasks from SharedPreferences',
        () async {
      when(mockSharedPreferences.getString('tasks')).thenReturn(taskJsonList);

      final result = await taskLocalDataSource.fetchTasks();

      expect(result, isA<List<TaskModel>>());
      expect(result.first.title, 'Test Task');
    });

    test('fetchTasks should return an empty list if no tasks are saved',
        () async {
      when(mockSharedPreferences.getString('tasks')).thenReturn(null);

      final result = await taskLocalDataSource.fetchTasks();

      expect(result, isEmpty);
    });
  });
}
