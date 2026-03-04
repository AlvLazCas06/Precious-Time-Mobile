part of 'task_create_bloc.dart';

@immutable
sealed class TaskCreateEvent {}

final class TaskCreateFetchEvent extends TaskCreateEvent {
  TaskCreateFetchEvent({
    required this.createTaskDto
  });
  final CreateTaskDto createTaskDto;
}
