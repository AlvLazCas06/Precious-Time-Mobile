import 'package:precious_time_mobile/core/models/project_response.dart';

class ProjectListResponse {
  final List<Project> content;

  ProjectListResponse({required this.content});

  factory ProjectListResponse.fromJson(List<dynamic> json) {
    return ProjectListResponse(
      content: List<Project>.from(
        json.map((item) => Project.fromJson(item)),
      ),
    );
  }

  List<dynamic> toJson() {
    return content.map((item) => item.toJson()).toList();
  }
}