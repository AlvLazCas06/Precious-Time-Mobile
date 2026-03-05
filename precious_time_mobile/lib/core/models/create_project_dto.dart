class CreateProjectDto {
  final String name;
  final String? description;
  final DateTime finishDate;

  CreateProjectDto({
    required this.name,
    this.description,
    required this.finishDate,
  });

  factory CreateProjectDto.fromJson(Map<String, dynamic> json) {
    return CreateProjectDto(
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      finishDate: DateTime.parse(json['finishDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'finishDate': finishDate.toIso8601String(),
    };
  }
}