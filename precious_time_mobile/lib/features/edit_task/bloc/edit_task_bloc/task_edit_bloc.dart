import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/edit_task_dto.dart';
import 'package:precious_time_mobile/core/service/task_service.dart';

part 'task_edit_event.dart';
part 'task_edit_state.dart';

class TaskEditBloc extends Bloc<TaskEditEvent, TaskEditState> {
  TaskEditBloc(TaskService taskService) : super(TaskEditInitial()) {
    on<TaskEditFetchEvent>((event, emit) async {
      emit(TaskEditLoading());
      try {
        await taskService.editTask(event.id, event.editTaskDto);
        emit(TaskEditSuccess());
      } catch (e) {
        emit(TaskEditError(message: e.toString()));
      }
    });
  }
}
