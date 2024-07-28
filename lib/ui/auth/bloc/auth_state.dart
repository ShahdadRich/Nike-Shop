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

class AuthError extends AuthState {
  const AuthError(super.isLoginMode);
}

class AuthLoading extends AuthState {
  const AuthLoading(super.isLoginMode);
}

class AuthSuccess extends AuthState {
  const AuthSuccess(super.isLoginMode);
}
