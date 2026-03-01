part of 'task_list_bloc.dart';

@immutable
sealed class TaskListEvent {}

final class TaskListFetchAllEvent extends TaskListEvent {}
