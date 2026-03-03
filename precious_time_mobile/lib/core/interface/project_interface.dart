import 'package:precious_time_mobile/core/models/project_list_response.dart';
import 'package:precious_time_mobile/core/models/projects_summary_list_response.dart';

abstract class ProjectInterface {
  Future<List<Project>> getProjects();
  Future<List<ProjectSummary>> getSummaryProjects();
}