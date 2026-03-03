part of 'task_home_bloc.dart';

@immutable
sealed class TaskHomeState {}

final class TaskHomeInitial extends TaskHomeState {}

final class TaskHomeLoading extends TaskHomeState {}

final class TaskHomeSuccess extends TaskHomeState {
  TaskHomeSuccess({
    required this.tasks
  });
  final List<TaskSummary> tasks;
}

final class TaskHomeError extends TaskHomeState {
  TaskHomeError({
    required this.message
  });
  final String message;
}
