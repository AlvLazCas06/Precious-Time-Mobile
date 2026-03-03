import 'dart:convert';

import 'package:precious_time_mobile/core/interface/project_interface.dart';
import 'package:precious_time_mobile/core/models/project_list_response.dart';
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
}
