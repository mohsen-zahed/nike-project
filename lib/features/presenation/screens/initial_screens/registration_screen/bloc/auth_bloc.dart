import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/repository/iauth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final IAuthRepository authRepository;
  AuthBloc({this.isLoginMode = true, required this.authRepository})
      : super(const AuthInitial(true)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonIsClicked) {
          emit(AuthLoading(isLoginMode));
          if (isLoginMode) {
            await authRepository.login(event.username, event.password);
            emit(AuthSuccess(isLoginMode));
          } else {
            await authRepository.register(event.username, event.password);
            emit(AuthSuccess(isLoginMode));
          }
        } else if (event is AuthModeChangeIsClicked) {
          isLoginMode = !isLoginMode;
          emit(AuthInitial(isLoginMode));
        }
      } catch (e) {
        emit(
          AuthFailed(isLoginMode, e.toString()),
        );
      }
    });
  }
}
