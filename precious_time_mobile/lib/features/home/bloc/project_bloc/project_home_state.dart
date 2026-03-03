part of 'project_home_bloc.dart';

@immutable
sealed class ProjectHomeState {}

final class ProjectHomeInitial extends ProjectHomeState {}

final class ProjectHomeLoading extends ProjectHomeState {}

final class ProjectHomeSuccess extends ProjectHomeState {
  ProjectHomeSuccess({
    required this.projects
  });
  final List<ProjectSummary> projects;
}

final class ProjectHomeError extends ProjectHomeState {
  ProjectHomeError({
    required this.message
  });
  final String message;
}
