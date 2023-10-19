import 'package:flutter/material.dart';
import 'package:anbutek_app/components/custom_bottom_nav_bar.dart';
import 'package:anbutek_app/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _userId;
  String? _profilePictureURL;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser!.uid;
    _fetchProfilePicture();
  }

  Future<void> _fetchProfilePicture() async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('$_userId.jpg');
      final downloadURL = await ref.getDownloadURL();
      setState(() {
        _profilePictureURL = downloadURL;
      });
    } catch (error) {
      // Handle the error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(profilePictureURL: _profilePictureURL),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
