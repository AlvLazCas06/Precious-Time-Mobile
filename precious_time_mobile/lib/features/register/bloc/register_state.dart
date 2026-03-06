part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  RegisterSuccess({
    required this.user
  });
  final UserResponse user;
}

final class RegisterError extends RegisterState {
  RegisterError({
    required this.message
  });
  final String message;
}
