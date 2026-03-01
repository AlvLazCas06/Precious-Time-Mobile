class AuthResponse {
  final String username;
  final String token;
  final List<String> roles;

  AuthResponse({
    required this.username,
    required this.token,
    required this.roles,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      username: json['username'] ?? '',
      token: json['token'] ?? '',
      roles: json['roles'] != null ? List<String>.from(json['roles']) 
          : ['USER'], 
    );
  }
}