import 'package:flutter/material.dart';
import 'package:anbutek_app/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp_screen";
  final String verificationId;
  final String phoneNumber;
  final String email;
  final String password;

  OtpScreen({
    required this.verificationId,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(
        verificationId: verificationId,
        phoneNumber: phoneNumber,
      ),
    );
  }
}
