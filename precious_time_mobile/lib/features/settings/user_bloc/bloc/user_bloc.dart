import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/user_response.dart';
import 'package:precious_time_mobile/core/service/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserService userService) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        var user = await userService.getUser();
        emit(UserSuccess(user: user));
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });
  }
}
