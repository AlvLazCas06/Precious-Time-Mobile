import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';

part 'project_view_event.dart';
part 'project_view_state.dart';

class ProjectViewBloc extends Bloc<ProjectViewEvent, ProjectViewState> {
  ProjectViewBloc(ProjectService projectService) : super(ProjectViewInitial()) {
    on<ProjectViewFetchEvent>((event, emit) async {
      emit(ProjectViewLoading());
      try {
        var project = await projectService.getProject(event.id);
        emit(ProjectViewSuccess(project: project));
      } catch (e) {
        emit(ProjectViewError(message: e.toString()));
      }
    });
    on<ProjectViewCancelEvent>((event, emit) async {
      emit(ProjectViewLoading());
      try {
        await projectService.cancelProject(event.id);
        emit(ProjectViewCancelSuccess());
      } catch (e) {
        emit(ProjectViewError(message: e.toString()));
      }
    });
  }
}
