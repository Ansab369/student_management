import 'package:flutter/material.dart';
import 'package:student_management/presentation/authentication/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
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