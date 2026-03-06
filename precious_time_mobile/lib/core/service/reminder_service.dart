import 'dart:convert';

import 'package:precious_time_mobile/core/interface/reminder_interface.dart';
import 'package:precious_time_mobile/core/models/reminder_list_response.dart';
import 'package:precious_time_mobile/core/models/reminder_response.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';

class ReminderService implements ReminderInterface {
  final ApiClient _apiClient = ApiClient(TokenManager());
  final String _endpoint = '/api/v1/reminders';

  @override
  Future<List<Reminder>> getReminders() async {
    try {
      var response = await _apiClient.get(_endpoint);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var reminders = ReminderListResponse.fromJson(
          jsonDecode(response.body),
        ).content;
        return reminders;
      }
      return [];
    } catch (e) {
      throw Exception('Error al cargar las notificaciones');
    }
  }

  @override
  Future<ReminderResponse> checkRead(int id) async {
    try {
      var response = await _apiClient.patch('$_endpoint/$id');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ReminderResponse.fromJson(jsonDecode(response.body));
      }
      Map<String, dynamic> map = jsonDecode(response.body);
      String detail = map['detail'];
      throw Exception('Error al marcar como leido: $detail');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
