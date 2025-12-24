part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

class SplashCheckingNetwork extends SplashState {}

class SplashNoInternet extends SplashState {}

class SplashNavigate extends SplashState {}
