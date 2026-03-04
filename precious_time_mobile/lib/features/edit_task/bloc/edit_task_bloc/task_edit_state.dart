part of 'task_edit_bloc.dart';

@immutable
sealed class TaskEditState {}

final class TaskEditInitial extends TaskEditState {}

final class TaskEditLoading extends TaskEditState {}

final class TaskEditSuccess extends TaskEditState {}

final class TaskEditError extends TaskEditState {
  TaskEditError({
    required this.message
  });
  final String message;
}
