import 'package:flutter/material.dart';
import 'package:anbutek_app/components/custom_bottom_nav_bar.dart';
import 'package:anbutek_app/enums.dart';
import 'package:anbutek_app/size_config.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back button action
        return Future.value(false);
      },
      child: Scaffold(
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}
