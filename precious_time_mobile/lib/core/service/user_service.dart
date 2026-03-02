import 'dart:convert';

import 'package:precious_time_mobile/core/interface/user_interface.dart';
import 'package:precious_time_mobile/core/models/user_response.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';

class UserService implements UserInterface {

  final String _urlBase = '/api/v1/users';
  final ApiClient _apiClient = ApiClient(TokenManager());

  @override
  Future<UserResponse?> getUser() async {
    try {
      var response = await _apiClient.get(_urlBase);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var user = UserResponse.fromJson(jsonDecode(response.body));
        return user;
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}