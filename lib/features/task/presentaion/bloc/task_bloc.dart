import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/domain/use_cases/delele_task_use_case.dart';
import 'package:task_manager/features/task/domain/use_cases/get_task_use_case.dart';
import '../../domain/use_cases/add_task_use_case.dart';
import '../../domain/use_cases/update_task_use_case.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskBloc({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskInitialState()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        final tasks = await getTasksUseCase(event.limit, event.skip);
        emit(TaskLoadedState(tasks));
      } catch (e) {
        emit(TaskErrorState(e.toString()));
      }
    });

    on<AddTaskEvent>((event, emit) async {
      try {
        await addTaskUseCase(event.task);
        add(LoadTasksEvent(limit: 10, skip: 0));
      } catch (e) {
        emit(TaskErrorState(e.toString()));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        await updateTaskUseCase(event.task);
        add(LoadTasksEvent(limit: 10, skip: 0));
      } catch (e) {
        emit(TaskErrorState(e.toString()));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await deleteTaskUseCase(event.taskId);
        add(LoadTasksEvent(limit: 10, skip: 0));
      } catch (e) {
        emit(TaskErrorState(e.toString()));
      }
    });
  }
}
