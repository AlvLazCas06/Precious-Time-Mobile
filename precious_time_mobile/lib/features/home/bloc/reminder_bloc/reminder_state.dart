part of 'reminder_bloc.dart';

@immutable
sealed class ReminderState {}

final class ReminderInitial extends ReminderState {}

final class ReminderLoading extends ReminderState {}

final class ReminderSuccess extends ReminderState {
  ReminderSuccess({
    required this.reminders
  });
  final List<Reminder> reminders;
}

final class ReminderReadSuccess extends ReminderState {}

final class ReminderError extends ReminderState {
  ReminderError({
    required this.message
  });
  final String message;
}
