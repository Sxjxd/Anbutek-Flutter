import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(45),
        width: getProportionateScreenWidth(45),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 227, 223, 223),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon!),
      ),
    );
  }
}