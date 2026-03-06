part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterCreateEvent extends RegisterEvent {
  RegisterCreateEvent({
    required this.dto
  });
  final CreateUserDto dto;
}
