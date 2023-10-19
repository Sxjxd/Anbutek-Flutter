import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

import '../../sign_in/sign_in_screen.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Gaming & Audio Store",
      "image": "assets/images/splash_1.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortrait = orientation == Orientation.portrait;

    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: isPortrait ? SizeConfig.screenHeight : SizeConfig.screenWidth,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) => SplashContent(
                image: splashData[index]["image"],
                text: splashData[index]['text'],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(isPortrait ? 20 : 40),
                vertical: getProportionateScreenHeight(isPortrait ? 10 : 20),
              ),
              child: DefaultButton(
                text: "Continue",
                press: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
