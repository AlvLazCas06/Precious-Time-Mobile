class EditTaskDto {
  final int categoryId;
  final int? projectId;
  final String title;
  final String description;
  final String priority;
  final DateTime completedAt;

  EditTaskDto({
    required this.categoryId,
    this.projectId,
    required this.title,
    required this.description,
    required this.priority,
    required this.completedAt
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'projectId': projectId,
      'title': title,
      'description': description,
      'priority': priority,
      'completedAt': completedAt.toIso8601String()
    };
  }

  factory EditTaskDto.fromJson(Map<String, dynamic> json) {
    return EditTaskDto(
      categoryId: json['categoryId'] as int,
      projectId: json['projectId'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String)
    );
  }
}