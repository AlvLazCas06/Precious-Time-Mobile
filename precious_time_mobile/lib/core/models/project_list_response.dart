class ProjectListResponse {
  final List<Project> content;
  final Page page;

  ProjectListResponse({
    required this.content,
    required this.page,
  });

  factory ProjectListResponse.fromJson(Map<String, dynamic> json) {
    return ProjectListResponse(
      content: (json['content'] as List<dynamic>)
          .map((item) => Project.fromJson(item as Map<String, dynamic>))
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

class Project {
  final int id;
  final String name;
  final String emoji;
  final String color;

  Project({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      color: json['color'] as String,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categoryName': categoryName,
      'priority': priority,
    };
  }
}