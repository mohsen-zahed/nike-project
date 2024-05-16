part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState(this.isLoginMode);

  final bool isLoginMode;
  @override
  List<Object> get props => [isLoginMode];
}

final class AuthInitial extends AuthState {
  const AuthInitial(super.isLoginMode);
}

final class AuthLoading extends AuthState {
  const AuthLoading(super.isLoginMode);
}

final class AuthSuccess extends AuthState {
  const AuthSuccess(super.isLoginMode);
}

final class AuthFailed extends AuthState {
  final String errorMessage;
  const AuthFailed(super.isLoginMode, this.errorMessage);
}
