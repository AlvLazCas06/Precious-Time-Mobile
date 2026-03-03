class ProjectsSummaryListResponse {
  final List<ProjectSummary> content;
  final PageInfo page;

  ProjectsSummaryListResponse({
    required this.content,
    required this.page,
  });

  factory ProjectsSummaryListResponse.fromJson(Map<String, dynamic> json) {
    return ProjectsSummaryListResponse(
      content: (json['content'] as List<dynamic>)
          .map((item) => ProjectSummary.fromJson(item as Map<String, dynamic>))
          .toList(),
      page: PageInfo.fromJson(json['page'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((item) => item.toJson()).toList(),
      'page': page.toJson(),
    };
  }
}

class ProjectSummary {
  final int id;
  final String name;
  final double percent;

  ProjectSummary({
    required this.id,
    required this.name,
    required this.percent,
  });

  factory ProjectSummary.fromJson(Map<String, dynamic> json) {
    return ProjectSummary(
      id: json['id'] as int,
      name: json['name'] as String,
      percent: (json['percent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'percent': percent,
    };
  }
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

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'number': number,
      'totalElements': totalElements,
      'totalPages': totalPages,
    };
  }
}