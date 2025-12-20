part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  const AuthFailure({required this.errorMessage});
}

final class AuthLogoutLoading extends AuthState {}

final class AuthLogoutSuccess extends AuthState {}

final class AuthDeleteAccountLoading extends AuthState {}

final class AuthDeleteAccountSuccess extends AuthState {
  final String message;

  const AuthDeleteAccountSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
