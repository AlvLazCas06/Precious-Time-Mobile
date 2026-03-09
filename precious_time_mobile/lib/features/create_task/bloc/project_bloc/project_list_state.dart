part of 'project_list_bloc.dart';

@immutable
sealed class ProjectListState {}

class ProjectListInitial extends ProjectListState {}

class ProjectListLoading extends ProjectListState {}

class ProjectListSuccess extends ProjectListState {
  final List<Project> projects;
  ProjectListSuccess({required this.projects});
}

class ProjectListError extends ProjectListState {
  final String message;
  ProjectListError({required this.message});
}
