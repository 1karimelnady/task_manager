// lib/features/task/domain/use_cases/add_task_use_case.dart
import 'package:task_manager/features/auth/data/repositories/auth_repositories_impl.dart';

import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase({required this.repository});

  Future<void> call(TaskEntity task) {
    return repository.addTask(task);
  }
}
