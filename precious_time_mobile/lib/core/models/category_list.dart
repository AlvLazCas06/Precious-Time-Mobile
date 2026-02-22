class CategoryListResponse {
  final List<Category> content;
  final Page page;

  CategoryListResponse({
    required this.content,
    required this.page,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) {
    return CategoryListResponse(
      content: (json['content'] as List<dynamic>)
          .map((item) => Category.fromJson(item as Map<String, dynamic>))
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