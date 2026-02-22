import 'package:precious_time_mobile/core/models/project_list_response.dart';

abstract class ProjectInterface {
  Future<List<Project>> getProjects();
}