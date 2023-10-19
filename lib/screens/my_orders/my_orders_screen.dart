import 'package:flutter/material.dart';
import 'components/body.dart';

class MyOrdersScreen extends StatelessWidget {
  static const String routeName = '/myorders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Activity'),
      ),
      body: Body(),
    );
  }
}
