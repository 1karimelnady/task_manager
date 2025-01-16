// lib/features/task/data/repositories/task_repository_impl.dart
import 'package:task_manager/features/task/data/data_sources/task_local_data_source.dart';
import 'package:task_manager/features/task/data/data_sources/task_remote_data_source.dart';
import 'package:task_manager/features/task/data/model/task_model.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<TaskEntity>> getTasks(int limit, int skip) async {
    final tasks = await remoteDataSource.fetchTasks(limit: limit, skip: skip);
    await localDataSource.saveTasks(tasks);
    return tasks;
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final newTask = await remoteDataSource.addTask(TaskModel(
      id: task.id,
      title: task.title,
      completed: task.completed,
    ));
    await localDataSource.saveTasks([newTask]);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final updatedTask = await remoteDataSource.updateTask(TaskModel(
      id: task.id,
      title: task.title,
      completed: task.completed,
    ));
    await localDataSource.saveTasks([updatedTask]);
  }

  @override
  Future<void> deleteTask(int id) async {
    await remoteDataSource.deleteTask(id);
  }
}
