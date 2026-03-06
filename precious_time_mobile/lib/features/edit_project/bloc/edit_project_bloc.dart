import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/create_project_dto.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';

part 'edit_project_event.dart';
part 'edit_project_state.dart';

class EditProjectBloc extends Bloc<EditProjectEvent, EditProjectState> {
  EditProjectBloc(ProjectService projectService) : super(EditProjectInitial()) {
    on<EditProjectFecthEvent>((event, emit) async {
      emit(EditProjectLoading());
      try {
        var project = await projectService.getProject(event.id);
        emit(EditProjectGetSuccess(project: project));
      } catch (e) {
        emit(EditProjectError(message: e.toString()));
      }
    });

    on<EditProjectSaveEvent>((event, emit) async {
      emit(EditProjectLoading());
      try {
        var project = await projectService.editProject(event.id, event.dto);
        emit(EditProjectGetSuccess(project: project));
      } catch (e) {
        emit(EditProjectError(message: e.toString()));
      }
    });
  }
}
