part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  UserSuccess({
    required this.user
  });
  final UserResponse? user;
}

final class UserError extends UserState {
  UserError({required this.message});
  final String message;
}
