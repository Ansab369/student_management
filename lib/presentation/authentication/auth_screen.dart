import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/application/auth/authentication_bloc.dart';
import 'package:student_management/constants/styles.dart';
import 'package:student_management/presentation/phone_authentication/phone_authentication_screen.dart';
import 'package:student_management/presentation/widgets/screen_title_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // controllers
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = false; // show password
  bool _showSignUp = false; // show password
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          // User is logged in, navigate to home screen
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => PaginationScreen(),
          // ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80.0),
                   ScreenTitle(
                    title: 'Welcome Back  👋',
                    subTitle: 'Please Enter Your Details to ${_showSignUp == true ? 'SignUp' : 'SignIn'}',
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelText: 'Email',
                      // prefixIcon: const Icon(Icons.email),
                      hintText: 'Enter Your Email',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    obscureText: !_showPassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      // prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextButton(
                    style: mainButtonStyle,
                    onPressed: () async {
                      final email = mobileController.text;
                      final password = passwordController.text;

                      if (_showSignUp == true) {
                        context
                            .read<AuthenticationBloc>()
                            .add(SubmitRegistretiondButtonClickedEvent(
                              email,
                              password,
                            ));
                      } else {
                        context
                            .read<AuthenticationBloc>()
                            .add(SubmitLoginButtonClickedEvent(
                              email,
                              password,
                            ));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _showSignUp == true ? 'SignUp' : 'SignIn',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Center(child: Text("OR")),
                  const SizedBox(height: 30),
                  // Replace "context" with your actual context
                  TextButton(
                    style: mainOutlineButtonStyle,
                    onPressed: () async {
                      // Replace with your Google Sign In logic
                      print("Sign In with Google clicked!");
                      context
                            .read<AuthenticationBloc>()
                            .add(SignInWithGoogleEvent(
                             context
                            ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/google.png",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "SignIn with Google",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    style: mainButtonStyle,
                    onPressed: () async {
                      // Replace with your Phone Sign In logic
                      print("Sign In with Phone clicked!");
                      Navigator.of(context).push(MaterialPageRoute(builder:  (context) => PhoneAuthenticationScreen(), ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "SignIn with Phone",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _showSignUp == true
                              ? "Alredy have an account?  "
                              : "Don't have an account?  ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showSignUp = !_showSignUp;
                            });
                          },
                          child: Text(
                            _showSignUp == true ? 'SignIn' : 'SignUp',
                            style: const TextStyle(
                              color: kBlueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// todo : make validation commen
// todo : add any toast message in register method if needed
//