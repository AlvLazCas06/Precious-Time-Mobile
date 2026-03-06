import 'package:precious_time_mobile/core/models/create_user_dto.dart';
import 'package:precious_time_mobile/core/models/user_response.dart';

abstract class UserInterface {
  Future<UserResponse?> getUser();
  Future<UserResponse> register(CreateUserDto dto);
}