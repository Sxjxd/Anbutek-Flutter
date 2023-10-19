import 'package:flutter/material.dart';

import 'components/body.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Body(),
    );
  }
}
