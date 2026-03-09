import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/task_list_response.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';

part 'task_home_event.dart';
part 'task_home_state.dart';

class TaskHomeBloc extends Bloc<TaskHomeEvent, TaskHomeState> {
  TaskHomeBloc(TaskService taskService) : super(TaskHomeInitial()) {
    on<TaskHomeEvent>((event, emit) async {
      emit(TaskHomeLoading());
      try {
        var tasks = await taskService.getTasks();
        emit(TaskHomeSuccess(tasks: tasks));
      } catch (e) {
        emit(TaskHomeError(message: e.toString()));
      }
    });
  }
}
