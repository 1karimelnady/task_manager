// lib/features/task/domain/entities/task_entity.dart
class TaskEntity {
  final int id;
  final String title;
  final bool completed;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.completed,
  });
}