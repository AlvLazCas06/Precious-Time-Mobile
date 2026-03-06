part of 'edit_project_bloc.dart';

@immutable
sealed class EditProjectEvent {}

final class EditProjectFecthEvent extends EditProjectEvent {
  EditProjectFecthEvent({
    required this.id
  });
  final int id;
}

final class EditProjectSaveEvent extends EditProjectEvent {
  EditProjectSaveEvent({
    required this.id,
    required this.dto
  });
  final int id;
  final CreateProjectDto dto;
}
