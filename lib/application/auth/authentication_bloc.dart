import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_management/domain/validations/validations.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    // on<AuthenticationEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<SubmitLoginButtonClickedEvent>((event, emit) async {
      print(event.email);
      print(event.password);
      //!
      //! validation
      if (event.email == null || event.email.isEmpty) {
        showErrorMessage("Please enter your email address.");
      } else if (!event.email.contains('@')) {
        showErrorMessage("Please enter a valid email address.");
      } else if (event.password == null || event.password.isEmpty) {
        showErrorMessage("Please enter your password.");
      } else if (event.password.length < 8) {
        showErrorMessage("Password must be at least 8 characters long.");
      } else {
        bool isLogin = await login(event.email, event.password);
        print("iuoiytuoytiutiut===========================");
        if (isLogin == true) {
          emit(AuthSuccessState(true));
        }
      }
    });

    on<SubmitRegistretiondButtonClickedEvent>((event, emit) async {
      bool isRegister = await register(event.email, event.password);
      if (isRegister == true) {
        emit(AuthSuccessState(true));
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {

      //   User? user =
      // await Authentication.signInWithGoogle(context: context);
        User? user =
      await signInWithGoogle(context: event.context);

      if (user != null) {
        // todo : navigate to home screen
        print("oooooooooooooooooooooooooooooooo");
      }

      // bool isRegister = await register(event.email, event.password);
      // if (isRegister == true) {
      //   emit(AuthSuccessState(true));
      // }
    });
    
    // on<SignInWithGoogleEvent>((event, emit) async {

    //   //   User? user =
    //   // await Authentication.signInWithGoogle(context: context);
    //     User? user =
    //   await signInWithGoogle(context: event.context);

    //   if (user != null) {
    //     // todo : navigate to home screen
    //     print("oooooooooooooooooooooooooooooooo");
    //   }

    //   // bool isRegister = await register(event.email, event.password);
    //   // if (isRegister == true) {
    //   //   emit(AuthSuccessState(true));
    //   // }
    // });
  }

  // loginaccount
  Future<bool> login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        showErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showErrorMessage('Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        showErrorMessage(
            'Invalid email address or password. Please try again.');
      } else {
        showErrorMessage('An unknown error occurred. Please try again later.');
      }
      return false;
    }
  }

// create new account
  Future<bool> register(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage('The account already exists for that email.');
      }
      return false;
    }
  }
  //! with google
  
 Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  Future<void> authenticateWithPhone(String phoneNumber) async {
  try {
    // Verify phone number using Firebase Phone Authentication.
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign in the user with the credential.
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure.
        print(e.message);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(e.message)),
        // );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verification ID for later use.
       String _verificationId = verificationId;

        // Navigate to a new screen for entering the verification code.
        // Navigator.pushNamed(context, '/otp_verification');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle code auto retrieval timeout.
     String   _verificationId = verificationId;
      },
    );
  } catch (error) {
    // Handle any errors during phone verification.
    print(error);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text(error.toString())),
    // );
  }
}
//!

}
