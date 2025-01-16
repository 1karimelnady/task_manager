import '../../domain/entities/task_entity.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {
  final int limit;
  final int skip;

  LoadTasksEvent({required this.limit, required this.skip});
}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;

  DeleteTaskEvent(this.taskId);
}
