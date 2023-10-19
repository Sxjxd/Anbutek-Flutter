import 'package:flutter/material.dart';

import 'components/body.dart';

class MyAccountScreen extends StatelessWidget {
  static const String routeName = '/myaccount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Body(),
    );
  }
}
