part of 'project_list_bloc.dart';

@immutable
sealed class ProjectListState {}

final class ProjectListInitial extends ProjectListState {}

final class ProjectListLoading extends ProjectListState {}

final class ProjectListSuccess extends ProjectListState {
  ProjectListSuccess({
    required this.projects
  });
  final List<Project> projects;
}

final class ProjectListError extends ProjectListState {
  ProjectListError({
    required this.message
  });
  final String message;
}
