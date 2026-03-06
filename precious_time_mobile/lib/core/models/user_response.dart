class UserResponse {
  final String username;
  final String email;
  final String name;
  final String lastname;
  final bool premium;
  final List<String> roles;

  UserResponse({
    required this.username,
    required this.email,
    required this.name,
    required this.lastname,
    required this.premium,
    required this.roles,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      lastname: json['lastname'] as String,
      premium: json['premium'] as bool,
      roles: List<String>.from(json['roles'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'lastname': lastname,
      'premium': premium,
      'roles': roles,
    };
  }
}