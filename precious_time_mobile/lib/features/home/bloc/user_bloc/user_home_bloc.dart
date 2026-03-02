import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/user_response.dart';
import 'package:precious_time_mobile/core/service/user_service.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc(UserService userService) : super(UserHomeInitial()) {
    on<UserHomeEvent>((event, emit) async {
      emit(UserHomeLoading());
      try {
        var user = await userService.getUser();
        emit(UserHomeSuccess(user: user!));
      } catch (e) {
        emit(UserHomeError(messsage: e.toString()));
      }
    });
  }
}
