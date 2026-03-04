part of 'task_create_bloc.dart';

@immutable
sealed class TaskCreateState {}

final class TaskCreateInitial extends TaskCreateState {}

final class TaskCreateLoading extends TaskCreateState {}

final class TaskCreateSuccess extends TaskCreateState {
  TaskCreateSuccess({
    required this.taskResponse
  });
  final TaskResponse taskResponse;
}

final class TaskCreateError extends TaskCreateState {
  TaskCreateError({
    required this.message
  });
  final String message;
}