class UserResponse {
  final String username;
  final String email;
  final String fullName;
  final bool premium;
  final List<String> roles;

  UserResponse({
    required this.username,
    required this.email,
    required this.fullName,
    required this.premium,
    required this.roles,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      premium: json['premium'] as bool,
      roles: List<String>.from(json['roles'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'fullName': fullName,
      'premium': premium,
      'roles': roles,
    };
  }
}