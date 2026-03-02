import 'package:precious_time_mobile/core/interface/preference_interface.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';

class PreferenceService implements PreferenceInterface {

  final ApiClient _apiClient = ApiClient(TokenManager());
  final String _endpoint = '/api/v1/preferences';

  @override
  Future<PreferenceResponse?> getPreference() async {
    try {
      var response = await _apiClient.get(_endpoint);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var preference = PreferenceResponse.fromJson(response.headers);
        return preference;
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}