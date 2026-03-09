import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';
part 'project_home_event.dart';
part 'project_home_state.dart';

class ProjectHomeBloc extends Bloc<ProjectHomeEvent, ProjectHomeState> {
  ProjectHomeBloc(ProjectService projectService) : super(ProjectHomeInitial()) {
    on<ProjectHomeEvent>((event, emit) async {
      emit(ProjectHomeLoading());
      try {
        var projects = await projectService.getProjects();
        emit(ProjectHomeSuccess(projects: projects));
      } catch (e) {
        emit(ProjectHomeError(message: e.toString()));
      }
    });
  }
}
