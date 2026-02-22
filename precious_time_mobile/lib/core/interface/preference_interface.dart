import 'package:precious_time_mobile/core/models/preference_response.dart';

abstract class PreferenceInterface {
  Future<PreferenceResponse> getPreference();
}