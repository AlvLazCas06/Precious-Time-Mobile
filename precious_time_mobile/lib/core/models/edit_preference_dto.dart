class EditPreferenceDto {
  final String type;
  final String theme;
  final bool notificationsActive;

  EditPreferenceDto({
    required this.type,
    required this.theme,
    required this.notificationsActive,
  });

  factory EditPreferenceDto.fromJson(Map<String, dynamic> json) {
    return EditPreferenceDto(
      type: json['type'] as String,
      theme: json['theme'] as String,
      notificationsActive: json['notificationsActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'theme': theme,
      'notificationsActive': notificationsActive,
    };
  }
}