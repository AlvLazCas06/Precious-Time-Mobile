part of 'project_create_bloc.dart';

@immutable
sealed class ProjectCreateEvent {}

final class ProjectCreateFetchEvent extends ProjectCreateEvent{
  ProjectCreateFetchEvent({
    required this.dto
  });
  final CreateProjectDto dto;
}
