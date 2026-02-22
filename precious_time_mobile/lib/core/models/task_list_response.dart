class TaskListResponse {
  final List<Task> content;
  final Page page;

  TaskListResponse({
    required this.content,
    required this.page,
  });

  factory TaskListResponse.fromJson(Map<String, dynamic> json) {
    return TaskListResponse(
      content: (json['content'] as List<dynamic>)
          .map((item) => Task.fromJson(item as Map<String, dynamic>))
          .toList(),
      page: Page.fromJson(json['page'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((item) => item.toJson()).toList(),
      'page': page.toJson(),
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
  final String? completedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.projectName,
    this.completedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      priority: json['priority'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      projectName: json['projectName'] as String,
      completedAt: json['completedAt'] as String?,
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
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      color: json['color'] as String,
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

class Page {
  final int size;
  final int number;
  final int totalElements;
  final int totalPages;

  Page({
    required this.size,
    required this.number,
    required this.totalElements,
    required this.totalPages,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      size: json['size'] as int,
      number: json['number'] as int,
      totalElements: json['totalElements'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'number': number,
      'totalElements': totalElements,
      'totalPages': totalPages,
    };
  }
}