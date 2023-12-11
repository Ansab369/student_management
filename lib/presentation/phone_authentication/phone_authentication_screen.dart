// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:student_management/application/auth/authentication_bloc.dart';
import 'package:student_management/constants/styles.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  const PhoneAuthenticationScreen({super.key});

  @override
  State<PhoneAuthenticationScreen> createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  bool isPhoneNumberSubmited = false;
  bool isagreeTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(90, 91, 92, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100),
                  Text(
                    "SignIn Account ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Connect with stores near you !",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 100),
                  isPhoneNumberSubmited
                      ? Text(
                          "OTP sented to +91 9876543210",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Text(
                          "Phone Number",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  SizedBox(height: 10),
                  isPhoneNumberSubmited
                      ? Pinput(
                          length: 6,
                          // controller: pinController,
                          // focusNode: focusNode,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(width: 5),
                          validator: (value) {
                            return value == '222222'
                                ? null
                                : 'Pin is incorrect';
                          },
                          // onClipboardFound: (value) {
                          //   debugPrint('onClipboardFound: $value');
                          //   pinController.setText(value);
                          // },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "+91",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "|",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your phone number',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(height: 10),
                  isPhoneNumberSubmited
                      ?
                      // TODO :
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Auto verifying"),
                              SizedBox(width: 20),
                              SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2)),
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            Transform.translate(
                              offset: const Offset(-5, 0),
                              child: Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                activeColor: Color(0xff6e509e),
                                value: isagreeTermsAndConditions,
                                onChanged: (value) {
                                  setState(() {
                                    isagreeTermsAndConditions = value!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "I agree to the terms and conditions",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isPhoneNumberSubmited = true;
                        });
                        if (!isPhoneNumberSubmited) {
                          //  context
                          //   .read<AuthenticationBloc>()
                          //   .add(SubmitRegistretiondButtonClickedEvent(
                          //     number,
                          //   ));
                        }else{
                          //  context
                          //   .read<AuthenticationBloc>()
                          //   .add(SubmitRegistretiondButtonClickedEvent(
                          //     otp,
                          //   ));
                        }
                        // Navigate to honme
                        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => TypeOfUserScreen()), (route) => false);
                      },
                      child: isPhoneNumberSubmited
                          ? Text(
                              'Verify OTP',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          : Text(
                              'Submit',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                      style: mainButtonStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// todo : show number error message
// todo : show OTP error message
