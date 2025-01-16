import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase({required this.repository});

  Future<List<TaskEntity>> call(int limit, int skip) {
    return repository.getTasks(limit, skip);
  }
}
