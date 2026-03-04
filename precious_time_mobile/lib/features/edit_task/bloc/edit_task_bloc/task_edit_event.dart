part of 'task_edit_bloc.dart';

@immutable
sealed class TaskEditEvent {}

final class TaskEditFetchEvent extends TaskEditEvent{
  TaskEditFetchEvent({
    required this.id,
    required this.editTaskDto
  });
  final int id;
  final EditTaskDto editTaskDto;
}
