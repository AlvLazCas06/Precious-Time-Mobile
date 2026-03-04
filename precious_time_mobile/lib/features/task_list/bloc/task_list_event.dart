part of 'task_list_bloc.dart';

@immutable
sealed class TaskListEvent {}

final class TaskListFetchAllEvent extends TaskListEvent {}

final class TaskDeleteEvent extends TaskListEvent {
  TaskDeleteEvent({
    required this.id
  });
  final int id;
}

final class TaskCompleteEvent extends TaskListEvent {
  TaskCompleteEvent({
    required this.id
  });
  final int id;
}
