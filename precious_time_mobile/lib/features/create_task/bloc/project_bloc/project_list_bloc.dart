import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/service/project_service.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc(ProjectService projectService) : super(ProjectListInitial()) {
    on<ProjectListFetchEvent>((event, emit) async {
      emit(ProjectListLoading());
      try {
        final all = await projectService.getProjects();
        final inProgress = all
            .where((p) => p.status.toLowerCase() == 'en progreso')
            .toList();
        emit(ProjectListSuccess(projects: inProgress));
      } catch (e) {
        emit(ProjectListError(message: e.toString()));
      }
    });
  }
}
