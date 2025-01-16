import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase({required this.repository});

  Future<void> call(int id) {
    return repository.deleteTask(id);
  }
}
