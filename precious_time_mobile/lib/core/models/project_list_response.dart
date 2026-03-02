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
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: Page.fromJson(json['page'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((e) => e.toJson()).toList(),
      'page': page.toJson(),
    };
  }
}

class Project {
  final int id;
  final String name;
  final String description;
  final String? startDate;
  final String? finishDate;
  final String status;
  final double progress;
  final String author;
  final List<dynamic> tasks;

  Project({
    required this.id,
    required this.name,
    required this.description,
    this.startDate,
    this.finishDate,
    required this.status,
    required this.progress,
    required this.author,
    required this.tasks,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String?,
      finishDate: json['finishDate'] as String?,
      status: json['status'] as String,
      progress: (json['progress'] as num).toDouble(),
      author: json['author'] as String,
      tasks: json['tasks'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate,
      'finishDate': finishDate,
      'status': status,
      'progress': progress,
      'author': author,
      'tasks': tasks,
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