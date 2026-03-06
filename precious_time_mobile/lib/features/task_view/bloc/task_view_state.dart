part of 'task_view_bloc.dart';

@immutable
sealed class TaskViewState {}

final class TaskViewInitial extends TaskViewState {}

final class TaskViewLoading extends TaskViewState {}

final class TaskViewSuccess extends TaskViewState {
  TaskViewSuccess({
    required this.taskResponse
  });
  final TaskResponse taskResponse;
}

final class TaskCompletedSuccess extends TaskViewState {}

final class TaskViewError extends TaskViewState {
  TaskViewError({
    required this.message
  });
  final String message;
}