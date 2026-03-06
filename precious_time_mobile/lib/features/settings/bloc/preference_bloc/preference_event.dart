part of 'preference_bloc.dart';

@immutable
sealed class PreferenceEvent {}

final class PreferenceFetchEvent extends PreferenceEvent {}

final class PreferenceEditEvent extends PreferenceEvent {
  PreferenceEditEvent({
    required this.id,
    required this.dto
  });
  final int id;
  final EditPreferenceDto dto;
}