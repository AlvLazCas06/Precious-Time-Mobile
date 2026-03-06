import 'package:precious_time_mobile/core/models/edit_preference_dto.dart';
import 'package:precious_time_mobile/core/models/preference_response.dart';

abstract class PreferenceInterface {
  Future<PreferenceResponse> getPreference();
  Future<PreferenceResponse> editPreference(int id, EditPreferenceDto dto);
  Future<PreferenceResponse> createPreference();
}