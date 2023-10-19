import 'package:flutter/material.dart';
import 'package:anbutek_app/screens/profile/components/profile_menu.dart';
import 'package:anbutek_app/screens/profile/components/profile_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anbutek_app/screens/sign_in/sign_in_screen.dart';
import 'package:anbutek_app/screens/profile/components/settings.dart';
import 'package:anbutek_app/screens/my_account/my_account_screen.dart';
import 'package:anbutek_app/screens/my_orders/my_orders_screen.dart';

class Body extends StatelessWidget {
  final String? profilePictureURL;

  const Body({Key? key, this.profilePictureURL}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.routeName, (route) => false);
    } catch (e) {
      // Handle sign-out error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(profilePictureURL: profilePictureURL),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/UserIcon.svg",
            press: () {
              Navigator.pushNamed(context, MyAccountScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "My Orders",
            icon: "assets/icons/myOrders.svg",
            press: () {
              Navigator.pushNamed(context, MyOrdersScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "About Us",
            icon: "assets/icons/QuestionMark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/LogOut.svg",
            press: () {
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
