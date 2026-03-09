import 'dart:convert';

import 'package:precious_time_mobile/core/interface/preference_interface.dart';
import 'package:precious_time_mobile/core/models/edit_preference_dto.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';
import 'package:http/http.dart' as http;

class PreferenceService implements PreferenceInterface {
  final ApiClient _apiClient = ApiClient(TokenManager());
  final String _endpoint = '/api/v1/preferences';
  final TokenManager _tokenManager = TokenManager();

  @override
  Future<PreferenceResponse> getPreference() async {
    try {
      var response = await _apiClient.get(_endpoint);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var preference = PreferenceResponse.fromJson(jsonDecode(response.body));
        return preference;
      }
      throw Exception();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PreferenceResponse> editPreference(
    int id,
    EditPreferenceDto dto,
  ) async {
    try {
      var response = await _apiClient.put('$_endpoint', dto.toJson());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return PreferenceResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PreferenceResponse> createPreference(String username) async {
    try {
      final token = await _tokenManager.getToken();
      var response = await http.post(Uri.parse('http://10.0.2.2:8080/api/v1/preferences'), body: username, headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return PreferenceResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
