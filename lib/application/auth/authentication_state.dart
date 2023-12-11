part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

 class AuthSuccessState extends AuthenticationState {
 final bool isAuthenticated ;
  AuthSuccessState(this.isAuthenticated);
 }
 class PoneNumberSubmitedState extends AuthenticationState {
 final bool isPoneNumberSubmited ;
  PoneNumberSubmitedState(this.isPoneNumberSubmited);
 }