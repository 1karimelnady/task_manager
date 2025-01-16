import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/features/task/data/data_sources/task_local_data_source.dart';
import 'package:task_manager/features/task/data/data_sources/task_remote_data_source.dart';
import 'package:task_manager/features/task/data/repositories/task_repositories_impl.dart';
import 'package:task_manager/features/task/data/model/task_model.dart';

class MockTaskRemoteDataSource extends Mock implements TaskRemoteDataSource {}

class MockTaskLocalDataSource extends Mock implements TaskLocalDataSource {}

void main() {
  late TaskRepositoryImpl taskRepository;
  late MockTaskRemoteDataSource mockTaskRemoteDataSource;
  late MockTaskLocalDataSource mockTaskLocalDataSource;

  setUp(() {
    mockTaskRemoteDataSource = MockTaskRemoteDataSource();
    mockTaskLocalDataSource = MockTaskLocalDataSource();
    taskRepository = TaskRepositoryImpl(
      remoteDataSource: mockTaskRemoteDataSource,
      localDataSource: mockTaskLocalDataSource,
    );
  });

  group('TaskRepositoryImpl', () {
    const taskId = 1;
    const taskTitle = 'Test Task';
    const taskCompleted = false;
    final TaskModel task =
        TaskModel(id: taskId, title: taskTitle, completed: taskCompleted);
    final List<TaskModel> tasksList = [task];

    test('should get tasks and save them locally', () async {
      when(mockTaskRemoteDataSource.fetchTasks(limit: 10, skip: 0))
          .thenAnswer((_) async => tasksList);

      final result = await taskRepository.getTasks(10, 0);

      expect(result, tasksList);
      verify(mockTaskLocalDataSource.saveTasks(tasksList)).called(1);
    });

    test('should add a new task', () async {
      when(mockTaskRemoteDataSource.addTask(task))
          .thenAnswer((_) async => task);

      await taskRepository.addTask(task);

      verify(mockTaskLocalDataSource.saveTasks([task])).called(1);
    });

    test('should update a task', () async {
      when(mockTaskRemoteDataSource.updateTask(task))
          .thenAnswer((_) async => task);

      await taskRepository.updateTask(task);

      verify(mockTaskLocalDataSource.saveTasks([task])).called(1);
    });

    test('should delete a task', () async {
      when(mockTaskRemoteDataSource.deleteTask(taskId))
          .thenAnswer((_) async {});

      await taskRepository.deleteTask(taskId);

      verify(mockTaskRemoteDataSource.deleteTask(taskId)).called(1);
    });
  });
}
