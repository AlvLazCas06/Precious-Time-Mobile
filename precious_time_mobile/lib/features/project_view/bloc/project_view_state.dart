part of 'project_view_bloc.dart';

@immutable
sealed class ProjectViewState {}

final class ProjectViewInitial extends ProjectViewState {}

final class ProjectViewLoading extends ProjectViewState {}

final class ProjectViewSuccess extends ProjectViewState {
  ProjectViewSuccess({
    required this.project
  });
  final Project project;
}

final class ProjectViewCancelSuccess extends ProjectViewState {}

final class ProjectViewCompleteTaskSuccess extends ProjectViewState {}

final class ProjectViewError extends ProjectViewState {
  ProjectViewError({
    required this.message
  });
  final String message;
}