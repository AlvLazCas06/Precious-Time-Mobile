part of 'preference_bloc.dart';

@immutable
sealed class PreferenceEvent {}

final class PreferenceFetchEvent extends PreferenceEvent {}