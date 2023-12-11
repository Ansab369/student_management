part of 'splash_bloc.dart';

// @immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}


final class UserAuthExistState extends SplashState {
  bool isAuthenticated ;
  UserAuthExistState(this.isAuthenticated);
 }

