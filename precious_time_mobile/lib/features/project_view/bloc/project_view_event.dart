part of 'project_view_bloc.dart';

@immutable
sealed class ProjectViewEvent {}

final class ProjectViewFetchEvent extends ProjectViewEvent {
  ProjectViewFetchEvent({
    required this.id
  });
  final int id;
}

final class ProjectViewCancelEvent extends ProjectViewEvent {
  ProjectViewCancelEvent({
    required this.id
  });
  final int id;
}
