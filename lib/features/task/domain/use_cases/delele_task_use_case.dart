// lib/features/task/domain/use_cases/delete_task_use_case.dart
import 'package:task_manager/features/auth/data/repositories/auth_repositories_impl.dart';

import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase({required this.repository});

  Future<void> call(int id) {
    return repository.deleteTask(id);
  }
}
