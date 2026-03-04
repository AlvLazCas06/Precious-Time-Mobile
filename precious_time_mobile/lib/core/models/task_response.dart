class TaskResponse {
  final int id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final Category category;
  final String projectName;
  final String author;
  final String? completedAt;

  TaskResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.projectName,
    required this.author,
    this.completedAt,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      priority: json['priority'],
      category: Category.fromJson(json['category']),
      projectName: json['projectName'],
      author: json['author'],
      completedAt: json['completedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'category': category.toJson(),
      'projectName': projectName,
      'author': author,
      'completedAt': completedAt,
    };
  }
}

class Category {
  final String name;
  final String emoji;
  final String color;

  Category({
    required this.name,
    required this.emoji,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      emoji: json['emoji'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'emoji': emoji,
      'color': color,
    };
  }
}