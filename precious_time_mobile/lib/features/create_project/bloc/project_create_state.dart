part of 'project_create_bloc.dart';

@immutable
sealed class ProjectCreateState {}

final class ProjectCreateInitial extends ProjectCreateState {}

final class ProjectCreateLoading extends ProjectCreateState {}

final class ProjectCreateSuccess extends ProjectCreateState {}

final class ProjectCreateError extends ProjectCreateState {
  ProjectCreateError({
    required this.message
  });
  final String message;
}
