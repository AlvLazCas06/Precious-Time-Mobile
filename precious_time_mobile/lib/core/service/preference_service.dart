import 'dart:convert';

import 'package:precious_time_mobile/core/interface/preference_interface.dart';
import 'package:precious_time_mobile/core/models/edit_preference_dto.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';

class PreferenceService implements PreferenceInterface {
  final ApiClient _apiClient = ApiClient(TokenManager());
  final String _endpoint = '/api/v1/preferences';

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
  Future<PreferenceResponse> createPreference() async {
    try {
      var response = await _apiClient.post(_endpoint);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return PreferenceResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
