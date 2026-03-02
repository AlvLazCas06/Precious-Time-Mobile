import 'package:precious_time_mobile/core/models/user_response.dart';

abstract class UserInterface {
  Future<UserResponse?> getUser();
}