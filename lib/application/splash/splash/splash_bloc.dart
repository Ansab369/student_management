import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:student_management/presentation/authentication/auth_screen.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckIsAuthenticated>((event, emit) {
      // TODO: check firebase user exist
      // todo : navigate based on logic

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // nav
        emit(
          UserAuthExistState(true)
        );
      } else {
       // nav to splash 
        emit(
          UserAuthExistState(false)
        );
       
      }
    });
  }
}
