import 'package:flutter/material.dart';
import 'package:anbutek_app/components/no_account_text.dart';
import 'package:anbutek_app/components/social_card.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
 @override
Widget build(BuildContext context) {
  final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return SafeArea(
    child: SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(isPortrait ? 20 : 40)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(isPortrait ? 28 : 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(isPortrait ? 5 : 10)),
              Text(
                "Sign in with your email and password\nor continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              SignForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: "assets/icons/google-icon.svg",
                    press: () {},
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  SocialCard(
                    icon: "assets/icons/facebook-2.svg",
                    press: () {},
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  SocialCard(
                    icon: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(isPortrait ? 20 : 30)),
              NoAccountText(),
            ],
          ),
        ),
      ),
    ),
  );
}
}
