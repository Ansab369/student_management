part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

//! SignIN
class SubmitLoginButtonClickedEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SubmitLoginButtonClickedEvent(this.email, this.password);
}

//! SignUP

class SubmitRegistretiondButtonClickedEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SubmitRegistretiondButtonClickedEvent(this.email, this.password);
}

//! Google
class SignInWithGoogleEvent extends AuthenticationEvent {
  final BuildContext context;
  SignInWithGoogleEvent(this.context);
}

//! Phone
class SubmitPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;
  SubmitPhoneNumberEvent(this.phoneNumber);
}

//! Verify OTP
class SubmitPhoneNumberOTPEvent extends AuthenticationEvent {
  final String otp;
  SubmitPhoneNumberOTPEvent(this.otp);
}
