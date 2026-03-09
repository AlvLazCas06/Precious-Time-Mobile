part of 'edit_project_bloc.dart';

@immutable
sealed class EditProjectState {}

final class EditProjectInitial extends EditProjectState {}

final class EditProjectLoading extends EditProjectState {}

final class EditProjectSuccess extends EditProjectState {}

final class EditProjectGetSuccess extends EditProjectState {
  EditProjectGetSuccess({
    required this.project
  });
  final Project project;
}

final class EditProjectError extends EditProjectState {
  EditProjectError({
    required this.message
  });
  final String message;
}
