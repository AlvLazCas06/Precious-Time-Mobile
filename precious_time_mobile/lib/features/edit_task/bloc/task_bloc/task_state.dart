part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskSuccess extends TaskState {
  TaskSuccess({
    required this.taskResponse
  });
  final TaskResponse taskResponse;
}

final class TaskError extends TaskState {
  TaskError({
    required this.message
  });
  final String message;
}
