import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/service/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;

  LoginBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final error = await _authService.login(event.email, event.password);

    if (error == null) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(error));
    }
  }
}
