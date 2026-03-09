import 'dart:convert';

import 'package:precious_time_mobile/core/interface/project_interface.dart';
import 'package:precious_time_mobile/core/models/create_project_dto.dart';
import 'package:precious_time_mobile/core/models/project_list_response.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/models/projects_summary_list_response.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';

class ProjectService implements ProjectInterface {
  final ApiClient _apiClient = ApiClient(TokenManager());
  final String _endpoint = '/api/v1/projects';

  @override
  Future<List<Project>> getProjects() async {
    try {
      var response = await _apiClient.get(_endpoint);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var projects = ProjectListResponse.fromJson(
          jsonDecode(response.body),
        ).content;
        return projects;
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProjectSummary>> getSummaryProjects() async {
    try {
      var response = await _apiClient.get('$_endpoint/summary');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var projects = ProjectsSummaryListResponse.fromJson(
          jsonDecode(response.body),
        ).content;
        return projects;
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Project> createProject(CreateProjectDto dto) async {
    try {
      var response = await _apiClient.post(_endpoint, body: dto.toJson());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Project.fromJson(jsonDecode(response.body));
      }
      Map<String, dynamic> map = jsonDecode(response.body);
      String invalidParams = map['invalid-params'].toString();
      throw Exception('Error al crear el proyecto: $invalidParams');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Project> getProject(int id) async {
    try {
      var response = await _apiClient.get('$_endpoint/$id');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Project.fromJson(jsonDecode(response.body));
      }
      Map<String, dynamic> map = jsonDecode(response.body);
      String detail = map['detail'];
      throw Exception('Error al cargar el proyecto: $detail');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Project> editProject(int id, CreateProjectDto dto) async {
    try {
      var response = await _apiClient.put('$_endpoint/$id', dto.toJson());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Project.fromJson(jsonDecode(response.body));
      }
      throw Exception('Error al editar el proyecto');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<Project> cancelProject(int id) async {
    try {
      var response = await _apiClient.patch('$_endpoint/cancel/$id');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Project.fromJson(jsonDecode(response.body));
      }
      Map<String, dynamic> map = jsonDecode(response.body);
      String detail = map['detail'];
      throw Exception('Error al cargar el proyecto: $detail');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
