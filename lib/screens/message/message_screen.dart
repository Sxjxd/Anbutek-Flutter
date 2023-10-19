import 'package:flutter/material.dart';
import 'components/body.dart';

class MessageScreen extends StatelessWidget {
  static const routeName = '/message';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Body(),
    );
  }
}
