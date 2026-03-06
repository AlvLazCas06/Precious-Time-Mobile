import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/create_user_dto.dart';
import 'package:precious_time_mobile/core/models/user_response.dart';
import 'package:precious_time_mobile/core/service/user_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(UserService userService) : super(RegisterInitial()) {
    on<RegisterCreateEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        var user = await userService.register(event.dto);
        emit(RegisterSuccess(user: user));
      } catch (e) {
        emit(RegisterError(message: e.toString()));
      }
    });
  }
}
