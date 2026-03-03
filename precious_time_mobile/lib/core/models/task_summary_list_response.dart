class TaskSummaryListResponse {
  final List<TaskSummary> content;
  final PageInfo page;

  TaskSummaryListResponse({
    required this.content,
    required this.page,
  });

  factory TaskSummaryListResponse.fromJson(Map<String, dynamic> json) {
    return TaskSummaryListResponse(
      content: (json['content'] as List<dynamic>)
          .map((item) => TaskSummary.fromJson(item as Map<String, dynamic>))
          .toList(),
      page: PageInfo.fromJson(json['page'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content.map((item) => item.toJson()).toList(),
        'page': page.toJson(),
      };
}

class TaskSummary {
  final int id;
  final String title;
  final TaskCategory category;
  final String priority;
  final String? completedAt;

  TaskSummary({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    this.completedAt,
  });

  factory TaskSummary.fromJson(Map<String, dynamic> json) {
    return TaskSummary(
      id: json['id'] as int,
      title: json['title'] as String,
      category: TaskCategory.fromJson(json['category'] as Map<String, dynamic>),
      priority: json['priority'] as String,
      completedAt: json['completedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category.toJson(),
        'priority': priority,
        'completedAt': completedAt,
      };
}

class TaskCategory {
  final String name;
  final String emoji;
  final String color;

  TaskCategory({
    required this.name,
    required this.emoji,
    required this.color,
  });

  factory TaskCategory.fromJson(Map<String, dynamic> json) {
    return TaskCategory(
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'emoji': emoji,
        'color': color,
      };
}

class PageInfo {
  final int size;
  final int number;
  final int totalElements;
  final int totalPages;

  PageInfo({
    required this.size,
    required this.number,
    required this.totalElements,
    required this.totalPages,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      size: json['size'] as int,
      number: json['number'] as int,
      totalElements: json['totalElements'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'number': number,
        'totalElements': totalElements,
        'totalPages': totalPages,
      };
}