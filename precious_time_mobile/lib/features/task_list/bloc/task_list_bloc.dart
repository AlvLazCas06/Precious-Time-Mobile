import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/task_list_response.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc(TaskService taskService) : super(TaskListInitial()) {
    on<TaskListFetchAllEvent>((event, emit) async {
      emit(TaskListLoading());
      try {
        var tasks = await taskService.getTasks();
        emit(TaskListSuccess(tasks: tasks));
      } catch (e) {
        emit(TaskListError(message: e.toString()));
      }
    });
  }
}
