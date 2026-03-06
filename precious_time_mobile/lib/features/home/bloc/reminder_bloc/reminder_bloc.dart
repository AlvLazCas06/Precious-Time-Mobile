import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/reminder_list_response.dart';
import 'package:precious_time_mobile/core/service/reminder_service.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc(ReminderService reminderService) : super(ReminderInitial()) {
    on<ReminderFetchAllEvent>((event, emit) async {
      emit(ReminderLoading());
      try {
        var reminders = await reminderService.getReminders();
        emit(ReminderSuccess(reminders: reminders));
      } catch (e) {
        emit(ReminderError(message: e.toString()));
      }
    });
    on<ReminderReadEvent>((event, emit) async {
      emit(ReminderLoading());
      try {
        await reminderService.checkRead(event.id);
        emit(ReminderReadSuccess());
      } catch (e) {
        emit(ReminderError(message: e.toString()));
      }
    });
  }
}
