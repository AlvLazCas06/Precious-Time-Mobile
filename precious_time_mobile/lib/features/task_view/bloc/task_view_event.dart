part of 'task_view_bloc.dart';

@immutable
sealed class TaskViewEvent {}

final class TaskViewFetchEvent extends TaskViewEvent {
  TaskViewFetchEvent({
    required this.id
  });
  final int id;
}

final class TaskCheckCompleteEvent extends TaskViewEvent {
  TaskCheckCompleteEvent({
    required this.id
  });
  final int id;
}