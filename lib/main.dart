import 'package:flutter/material.dart';
import 'package:anbutek_app/routes.dart';
import 'package:anbutek_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anbutek_app/firebase_options.dart';
import 'package:anbutek_app/screens/loading_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Anbutek());
}

class Anbutek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anbutek App',
      theme: theme(),
      initialRoute: LoadingScreen.routeName,
      routes: routes,
    );
  }
}
