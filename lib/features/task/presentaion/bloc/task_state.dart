import '../../domain/entities/task_entity.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TaskEntity> tasks;

  TaskLoadedState(this.tasks);
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}
