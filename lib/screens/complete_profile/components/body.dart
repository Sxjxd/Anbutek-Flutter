import 'package:flutter/material.dart';
import 'package:anbutek_app/constants.dart';
import 'package:anbutek_app/size_config.dart';


import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  final String email;
  final String password;

  Body({required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Complete Profile", style: headingStyle),
                Text(
                  "Enter your details to continue",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(email: email, password: password),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "By continuing you confirm that you agree \nwith our Terms and Conditions*",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
