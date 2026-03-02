import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/project_list_response.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc(ProjectService projectService) : super(ProjectListInitial()) {
    on<ProjectListFetchAllEvent>((event, emit) async {
      emit(ProjectListLoading());
      try {
        var projects = await projectService.getProjects();
        emit(ProjectListSuccess(projects: projects));
      } catch (e) {
        emit(ProjectListError(message: e.toString()));
      }
    });
  }
}
