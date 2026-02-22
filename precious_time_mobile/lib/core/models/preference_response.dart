class PreferenceResponse {
  final bool notificationsActive;
  final String theme;
  final String type;

  PreferenceResponse({
    required this.notificationsActive,
    required this.theme,
    required this.type,
  });

  factory PreferenceResponse.fromJson(Map<String, dynamic> json) {
    return PreferenceResponse(
      notificationsActive: json['notificationsActive'] as bool,
      theme: json['theme'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationsActive': notificationsActive,
      'theme': theme,
      'type': type,
    };
  }
}