class ReminderResponse {
  final int id;
  final String title;
  final String message;
  final bool read;
  final String sendAt;

  ReminderResponse({
    required this.id,
    required this.title,
    required this.message,
    required this.read,
    required this.sendAt,
  });

  factory ReminderResponse.fromJson(Map<String, dynamic> json) {
    return ReminderResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      message: json['message'] as String,
      read: json['read'] as bool,
      sendAt: json['sendAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'read': read,
      'sendAt': sendAt,
    };
  }
}