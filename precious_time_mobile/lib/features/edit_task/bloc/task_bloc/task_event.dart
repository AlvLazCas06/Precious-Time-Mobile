part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class TaskFetchEvent extends TaskEvent {
  TaskFetchEvent({
    required this.id
  });
  final int id;
}
