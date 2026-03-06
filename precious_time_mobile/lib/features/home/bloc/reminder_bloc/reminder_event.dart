part of 'reminder_bloc.dart';

@immutable
sealed class ReminderEvent {}

final class ReminderFetchAllEvent extends ReminderEvent {}

final class ReminderReadEvent extends ReminderEvent {
  ReminderReadEvent({
    required this.id
  });
  final int id;
}
