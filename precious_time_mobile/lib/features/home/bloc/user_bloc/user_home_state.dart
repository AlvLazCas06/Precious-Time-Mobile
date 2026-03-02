part of 'user_home_bloc.dart';

@immutable
sealed class UserHomeState {}

final class UserHomeInitial extends UserHomeState {}

final class UserHomeLoading extends UserHomeState {}

final class UserHomeSuccess extends UserHomeState {
  UserHomeSuccess({
    required this.user
  });
  final UserResponse user;
}

final class UserHomeError extends UserHomeState {
  UserHomeError({
    required this.messsage
  });
  final String messsage;
}