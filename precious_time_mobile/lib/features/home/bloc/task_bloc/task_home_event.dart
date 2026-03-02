part of 'task_home_bloc.dart';

@immutable
sealed class TaskHomeEvent {}

final class TaskHomeFetchEvent extends TaskHomeEvent {}