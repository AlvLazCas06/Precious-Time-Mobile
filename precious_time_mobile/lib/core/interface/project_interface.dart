import 'package:precious_time_mobile/core/models/create_project_dto.dart';
import 'package:precious_time_mobile/core/models/project_response.dart';
import 'package:precious_time_mobile/core/models/projects_summary_list_response.dart';

abstract class ProjectInterface {
  Future<List<Project>> getProjects();
  Future<List<ProjectSummary>> getSummaryProjects();
  Future<Project> createProject(CreateProjectDto dto);
  Future<Project> getProject(int id);
  Future<Project> editProject(int id, CreateProjectDto dto);
  Future<Project> cancelProject(int id);
}