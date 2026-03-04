part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserFetchEvent extends UserEvent {}
