class CreateUserDto {
  final String username;
  final String password;
  final String verifyPassword;
  final String name;
  final String lastname;
  final String email;

  const CreateUserDto({
    required this.username,
    required this.password,
    required this.verifyPassword,
    required this.name,
    required this.lastname,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'verifyPassword': verifyPassword,
        'name': name,
        'lastname': lastname,
        'email': email,
      };

  factory CreateUserDto.fromJson(Map<String, dynamic> json) => CreateUserDto(
        username: json['username'] as String,
        password: json['password'] as String,
        verifyPassword: json['verifyPassword'] as String,
        name: json['name'] as String,
        lastname: json['lastname'] as String,
        email: json['email'] as String,
      );
}
