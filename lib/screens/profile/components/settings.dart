import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool enableLocation = false;
  bool enablePushNotifications = false;
  GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _configureFirebaseMessaging();
  }

  Future<void> _checkLocationPermission() async {
    final permissionStatus = await Permission.locationWhenInUse.status;
    setState(() {
      enableLocation = permissionStatus.isGranted;
    });
  }

  Future<void> _requestLocationPermission() async {
    final permissionStatus = await Permission.locationWhenInUse.request();
    setState(() {
      enableLocation = permissionStatus.isGranted;
    });

    if (enableLocation) {
      final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Location Services Enabled"),
            content: Text("Please turn on location."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Geolocator.openLocationSettings(); // Open device location settings
                },
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Location Access Disabled"),
          content: Text("Please enable location access to use this feature."),
          actions: [
            TextButton(
              child: Text("Go to Settings"),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                openAppSettings(); // Open app settings to enable location permission
              },
            ),
          ],
        ),
      );
    }
  }

  void _configureFirebaseMessaging() {
    firebaseMessaging.requestPermission();
    firebaseMessaging.getToken().then((token) {
      print("Firebase Messaging Token: $token");
      // Use the token for sending push notifications to this device
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received push notification: ${message.notification?.title}");
      // Handle the received push notification
    });
  }

  void _handlePushNotificationToggle(bool value) {
    setState(() {
      enablePushNotifications = value;
    });

    if (value) {
      // User turned on push notifications
      // Implement the logic for enabling push notifications
      showSnackBar("Push notifications enabled");
    } else {
      // User turned off push notifications
      // Implement the logic for disabling push notifications
      showSnackBar("Push notifications disabled");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Push Notifications",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch.adaptive(
                  value: enablePushNotifications,
                  onChanged: _handlePushNotificationToggle,
                  activeColor: Theme.of(context).primaryColor,
                  activeTrackColor: Theme.of(context)
                      .primaryColor
                      .withOpacity(0.5),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable Location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch.adaptive(
                  value: enableLocation,
                  onChanged: (value) {
                    setState(() {
                      enableLocation = value;
                      if (value) {
                        _requestLocationPermission();
                      } else {
                        // Location access is turned off
                        // Implement the logic for disabling location access
                        showSnackBar("Location access disabled");
                      }
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                  activeTrackColor: Theme.of(context)
                      .primaryColor
                      .withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
