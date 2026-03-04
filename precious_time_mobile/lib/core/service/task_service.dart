import 'dart:convert';

import 'package:precious_time_mobile/core/interface/task_interface.dart';
import 'package:precious_time_mobile/core/models/create_task_dto.dart';
import 'package:precious_time_mobile/core/models/edit_task_dto.dart';
import 'package:precious_time_mobile/core/models/task_list_response.dart';
import 'package:precious_time_mobile/core/models/task_summary_list_response.dart';
import 'package:precious_time_mobile/core/models/task_response.dart';
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
        var tasks = TaskListResponse.fromJson(
          jsonDecode(response.body),
        ).content;
        return tasks;
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TaskSummary>> getSummaryTasks() async {
    try {
      var response = await _apiClient.get('$_endpoint/summary');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var tasks = TaskSummaryListResponse.fromJson(
          jsonDecode(response.body),
        ).content;
        return tasks;
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<TaskResponse> createTask(CreateTaskDto createTaskDto) async {
    try {
      var response = await _apiClient.post(
        _endpoint,
        body: createTaskDto.toJson(),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return TaskResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception('Error al crear la tarea: ${response.statusCode}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<TaskResponse> checkCompleted(int id) async {
    try {
      var response = await _apiClient.patch('$_endpoint/$id/completed');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return TaskResponse.fromJson(jsonDecode(response.body));
      }
      Map<String, dynamic> map = jsonDecode(response.body);
      String detail = map['detail'];
      throw Exception('Error al marcar como completada: $detail');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<TaskResponse> getTask(int id) async {
    try {
      var response = await _apiClient.get('$_endpoint/$id');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return TaskResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception('Error al obtener la tarea: ${response.body}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<TaskResponse> editTask(int id, EditTaskDto editTaskDto) async {
    try {
      var response = await _apiClient.put('$_endpoint/$id', editTaskDto.toJson());
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return TaskResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception('Error al editar la tarea: ${response.statusCode}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<void> deleteTask(int id) async {
    try {
      var response = await _apiClient.delete('$_endpoint/$id');
      if (response.statusCode != 204) {
        throw Exception('Error al eliminar la tarea: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
