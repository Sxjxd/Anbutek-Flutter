import 'package:flutter/material.dart';
import 'package:anbutek_app/components/default_button.dart';
import 'package:anbutek_app/screens/home/home_screen.dart';
import 'package:anbutek_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Image.asset(
              "assets/images/Order Success.png",
              height: SizeConfig.screenHeight * 0.4,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Text(
              "Thank you for your order!",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: DefaultButton(
                text: "Back to Home",
                press: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
