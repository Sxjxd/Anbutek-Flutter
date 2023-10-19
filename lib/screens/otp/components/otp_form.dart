import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anbutek_app/components/default_button.dart';
import 'package:anbutek_app/size_config.dart';
import 'package:anbutek_app/screens/home/home_screen.dart';

import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  final String verificationId;
  
  const OtpForm({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late List<TextEditingController> pinControllers;
  late List<FocusNode> pinFocusNodes;

  @override
  void initState() {
    super.initState();
    pinControllers = List.generate(6, (_) => TextEditingController());
    pinFocusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    super.dispose();
    pinControllers.forEach((controller) => controller.dispose());
    pinFocusNodes.forEach((focusNode) => focusNode.dispose());
  }

  void nextField(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(pinFocusNodes[index + 1]);
    }
  }

  Future<void> _verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Verification successful, proceed to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      // Handle verification failure
      print('OTP verification failed: $e');
      // Display an error message to the user or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  controller: pinControllers[index],
                  focusNode: pinFocusNodes[index],
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, index),
                  maxLength: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
              // Get the OTP code entered by the user
              String otp = pinControllers
                  .map((controller) => controller.text)
                  .join();

              // Verify the OTP manually by calling the _verifyOTP method
              _verifyOTP(otp);
            },
          ),
        ],
      ),
    );
  }
}
