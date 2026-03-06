import 'package:precious_time_mobile/core/models/create_project_dto.dart';
import 'package:precious_time_mobile/core/models/project_list_response.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/models/projects_summary_list_response.dart';

abstract class ProjectInterface {
  Future<List<Project>> getProjects();
  Future<List<ProjectSummary>> getSummaryProjects();
  Future<ProjectResponse> createProject(CreateProjectDto dto);
  Future<ProjectResponse> getProject(int id);
  Future<ProjectResponse> editProject(int id, CreateProjectDto dto);
  Future<ProjectResponse> cancelProject(int id);
}