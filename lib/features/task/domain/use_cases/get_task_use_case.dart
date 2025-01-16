// lib/features/task/domain/use_cases/get_tasks_use_case.dart
import 'package:task_manager/features/auth/data/repositories/auth_repositories_impl.dart';

import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase({required this.repository});

  Future<List<TaskEntity>> call(int limit, int skip) {
    return repository.getTasks(limit, skip);
  }
}
