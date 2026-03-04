import 'package:precious_time_mobile/core/models/create_task_dto.dart';
import 'package:precious_time_mobile/core/models/task_list_response.dart';
import 'package:precious_time_mobile/core/models/task_summary_list_response.dart';
import 'package:precious_time_mobile/core/models/task_response.dart';

abstract class TaskInterface {
  Future<List<Task>> getTasks();
  Future<List<TaskSummary>> getSummaryTasks();
  Future<TaskResponse> createTask(CreateTaskDto createTaskDto);
  Future<TaskResponse> checkCompleted(int id);
}