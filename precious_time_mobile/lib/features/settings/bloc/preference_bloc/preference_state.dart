part of 'preference_bloc.dart';

@immutable
sealed class PreferenceState {}

final class PreferenceInitial extends PreferenceState {}

final class PreferenceLoading extends PreferenceState {}

final class PreferenceSuccess extends PreferenceState {
  PreferenceSuccess({
    required this.preferenceResponse
  });
  final PreferenceResponse preferenceResponse;
}

final class PreferenceEditSuccess extends PreferenceState {
  PreferenceEditSuccess({
    required this.preferenceResponse
  });
  final PreferenceResponse preferenceResponse;
}

final class PreferenceError extends PreferenceState {
  PreferenceError({
    required this.message
  });
  final String message;
}
