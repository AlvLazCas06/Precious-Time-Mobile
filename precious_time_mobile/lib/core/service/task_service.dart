import 'package:precious_time_mobile/core/interface/task_interface.dart';
import 'package:precious_time_mobile/core/models/task_list_response.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';

class TaskService implements TaskInterface {
  final ApiClient _apiClient = ApiClient(TokenManager());
  final String _endpoint = '/api/v1/tasks';

  @override
  Future<List<Task>> getTasks() async {
    try {
      var response = await _apiClient.get(_endpoint);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var tasks = TaskListResponse.fromJson(response.headers).content;
        return tasks;
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
