class ReminderListResponse {
  final List<Reminder> content;
  final PageInfo page;

  ReminderListResponse({
    required this.content,
    required this.page,
  });

  factory ReminderListResponse.fromJson(Map<String, dynamic> json) {
    return ReminderListResponse(
      content: List<Reminder>.from(
        (json['content'] as List).map((item) => Reminder.fromJson(item)),
      ),
      page: PageInfo.fromJson(json['page']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((item) => item.toJson()).toList(),
      'page': page.toJson(),
    };
  }
}

class Reminder {
  final int id;
  final String title;
  final String message;
  final bool read;
  final String sendAt;

  Reminder({
    required this.id,
    required this.title,
    required this.message,
    required this.read,
    required this.sendAt,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      read: json['read'],
      sendAt: json['sendAt'],
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
      size: json['size'],
      number: json['number'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
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