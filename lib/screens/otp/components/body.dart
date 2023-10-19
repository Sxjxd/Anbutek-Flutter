import 'package:flutter/material.dart';
import 'package:anbutek_app/constants.dart';
import 'package:anbutek_app/size_config.dart';

import 'otp_form.dart';


class Body extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;

  const Body({
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to $phoneNumber"), // Display the phone number
              buildTimer(),
              OtpForm(verificationId: verificationId),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // Handle OTP code resend
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt().toString().padLeft(2, '0')}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
