import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/create_task_dto.dart';
import 'package:precious_time_mobile/core/models/task_response.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';

part 'task_create_event.dart';
part 'task_create_state.dart';

class TaskCreateBloc extends Bloc<TaskCreateEvent, TaskCreateState> {
  TaskCreateBloc(TaskService taskService) : super(TaskCreateInitial()) {
    on<TaskCreateFetchEvent>((event, emit) async {
      emit(TaskCreateLoading());
      try {
        var task = await taskService.createTask(event.createTaskDto);
        emit(TaskCreateSuccess(taskResponse: task));
      } catch (e) {
        emit(TaskCreateError(message: e.toString()));
      }
    });
  }
}
