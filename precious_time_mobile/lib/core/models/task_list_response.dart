class TaskListResponse {
  final List<Task> content;

  TaskListResponse({required this.content});

  factory TaskListResponse.fromJson(Map<String, dynamic> json) {
    return TaskListResponse(
      content: List<Task>.from(
        (json['content'] as List).map((item) => Task.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((task) => task.toJson()).toList(),
    };
  }
}

class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final Category category;
  final String projectName;
  final String author;
  final String completedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.projectName,
    required this.author,
    required this.completedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
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
  final int id;
  final String name;
  final String emoji;
  final String color;

  Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      emoji: json['emoji'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'color': color,
    };
  }
}