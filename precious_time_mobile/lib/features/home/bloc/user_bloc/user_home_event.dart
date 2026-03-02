part of 'user_home_bloc.dart';

@immutable
sealed class UserHomeEvent {}

final class UserHomeFetchEvent extends UserHomeEvent {}