import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/splash/splash/splash_bloc.dart';
import 'package:student_management/presentation/authentication/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      BlocProvider.of<SplashBloc>(context)
          .add(CheckIsAuthenticated()); // Call Bloc function

// todo : remove
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
          (route) => false);
    });

    return Scaffold(
      body: Center(child: Image.asset('logo.png')),
    );
  }
}


// todo : check is auth
// todo : navigate to auth screen / home screen