import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);

  final String? text, image;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortrait = orientation == Orientation.portrait;

    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(isPortrait ? 20 : 40),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "ANBUTEK",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(isPortrait ? 36 : 24),
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(isPortrait ? 10 : 5)),
                      Text(
                        text!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(isPortrait ? 18 : 14),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(isPortrait ? 80 : 20)),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                  child: Image.asset(
                    image!,
                    width: double.infinity,
                    height: getProportionateScreenHeight(isPortrait ? 500 : 300),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
