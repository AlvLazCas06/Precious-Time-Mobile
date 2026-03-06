import 'package:precious_time_mobile/core/models/reminder_list_response.dart';
import 'package:precious_time_mobile/core/models/reminder_response.dart';

abstract class ReminderInterface {
  Future<List<Reminder>> getReminders();
  Future<ReminderResponse> checkRead(int id);
}