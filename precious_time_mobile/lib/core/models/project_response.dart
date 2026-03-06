class ProjectResponse {
  final int id;
  final String name;
  final String? description;
  final String startDate;
  final String finishDate;
  final String status;
  final double progress;
  final String author;
  final List<Task> tasks;

  ProjectResponse({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    required this.finishDate,
    required this.status,
    required this.progress,
    required this.author,
    required this.tasks,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      finishDate: json['finishDate'] as String? ?? '',
      status: json['status'] as String? ?? '',
      progress: (json['progress'] as num).toDouble(),
      author: json['author'] as String? ?? '',
      tasks: (json['tasks'] as List<dynamic>)
          .map((task) => Task.fromJson(task as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'startDate': startDate,
    'finishDate': finishDate,
    'status': status,
    'progress': progress,
    'author': author,
    'tasks': tasks.map((task) => task.toJson()).toList(),
  };
}

class Task {
  final int id;
  final String title;
  final String categoryName;
  final String priority;

  Task({
    required this.id,
    required this.title,
    required this.categoryName,
    required this.priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      categoryName: json['categoryName'] as String,
      priority: json['priority'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'categoryName': categoryName,
    'priority': priority,
  };
}
