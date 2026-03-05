import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/create_project_dto.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';

part 'project_create_event.dart';
part 'project_create_state.dart';

class ProjectCreateBloc extends Bloc<ProjectCreateEvent, ProjectCreateState> {
  ProjectCreateBloc(ProjectService projectService): super(ProjectCreateInitial()) {
    on<ProjectCreateFetchEvent>((event, emit) async {
      emit(ProjectCreateLoading());
      try {
        await projectService.createProject(event.dto);
        emit(ProjectCreateSuccess());
      } catch (e) {
        emit(ProjectCreateError(message: e.toString()));
      }
    });
  }
}
