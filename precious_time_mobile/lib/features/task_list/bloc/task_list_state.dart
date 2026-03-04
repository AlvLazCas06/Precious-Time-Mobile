part of 'task_list_bloc.dart';

@immutable
sealed class TaskListState {}

final class TaskListInitial extends TaskListState {}

final class TaskListLoading extends TaskListState {}

final class TaskListSuccess extends TaskListState {
  TaskListSuccess({
    required this.tasks
  });
  final List<Task> tasks;
}

final class TaskDeleteSuccess extends TaskListState {}

final class TaskCompleteSuccess extends TaskListState {}

final class TaskListError extends TaskListState {
  TaskListError({
    required this.message
  });
  final String message;
}
