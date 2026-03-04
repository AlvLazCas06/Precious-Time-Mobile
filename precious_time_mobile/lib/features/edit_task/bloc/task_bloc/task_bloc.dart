import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/task_response.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(TaskService taskService) : super(TaskInitial()) {
    on<TaskFetchEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        var task = await taskService.getTask(event.id);
        emit(TaskSuccess(taskResponse: task));
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });
  }
}
