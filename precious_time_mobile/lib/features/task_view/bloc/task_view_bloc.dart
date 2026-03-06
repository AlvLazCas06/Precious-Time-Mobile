import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/task_response.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';

part 'task_view_event.dart';
part 'task_view_state.dart';

class TaskViewBloc extends Bloc<TaskViewEvent, TaskViewState> {
  TaskViewBloc(TaskService taskService) : super(TaskViewInitial()) {
    on<TaskViewFetchEvent>((event, emit) async {
      emit(TaskViewLoading());
      try {
        var task = await taskService.getTask(event.id);
        emit(TaskViewSuccess(taskResponse: task));
      } catch (e) {
        emit(TaskViewError(message: e.toString()));
      }
    });

    on<TaskCheckCompleteEvent>((event, emit) async {
      emit(TaskViewLoading());
      try {
        await taskService.checkCompleted(event.id);
        emit(TaskCompletedSuccess());
      } catch (e) {
        emit(TaskViewError(message: e.toString()));
      }
    });
  }
}
