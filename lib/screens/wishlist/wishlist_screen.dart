import 'package:flutter/material.dart';
import 'package:anbutek_app/screens/wishlist/components/body.dart';


class WishlistScreen extends StatelessWidget {
  static String routeName = "/wishlist";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: Body(),
    );
  }
}
