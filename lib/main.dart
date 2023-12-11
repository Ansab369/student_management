import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/auth/authentication_bloc.dart';
import 'package:student_management/application/splash/splash/splash_bloc.dart';
import 'package:student_management/firebase_options.dart';
import 'package:student_management/presentation/splash/splash_screen.dart';

import 'presentation/authentication/auth_screen.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
       providers: [
        BlocProvider(create: (ctx) => SplashBloc()),
        BlocProvider(create: (ctx) => AuthenticationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthScreen(),
        // home: SplashScreen(),
      ),
    );
  }
}

// todo : use goRouter for routing
// todo : use 