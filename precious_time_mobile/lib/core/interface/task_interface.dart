import 'package:precious_time_mobile/core/models/task_list_response.dart';

abstract class TaskInterface {
  Future<List<Task>> getTasks();
}