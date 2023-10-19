
import 'package:flutter/widgets.dart';
import 'package:anbutek_app/screens/cart/cart_screen.dart';
import 'package:anbutek_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:anbutek_app/screens/details/details_screen.dart';
import 'package:anbutek_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:anbutek_app/screens/home/home_screen.dart';
import 'package:anbutek_app/screens/login_success/login_success_screen.dart';
import 'package:anbutek_app/screens/profile/profile_screen.dart';
import 'package:anbutek_app/screens/profile/components/settings.dart';
import 'package:anbutek_app/screens/sign_in/sign_in_screen.dart';
import 'package:anbutek_app/screens/splash/splash_screen.dart';
import 'package:anbutek_app/screens/sign_up/sign_up_screen.dart';
import 'package:anbutek_app/screens/notification/notification_screen.dart';
import 'package:anbutek_app/screens/my_account/my_account_screen.dart';
import 'package:anbutek_app/screens/my_orders/my_orders_screen.dart';
import 'package:anbutek_app/screens/wishlist/wishlist_screen.dart';
import 'package:anbutek_app/screens/message/message_screen.dart';
import 'package:anbutek_app/screens/loading_screen.dart';
import 'package:anbutek_app/screens/checkout/checkout_screen.dart';
import 'package:anbutek_app/screens/order_success/order_success_screen.dart';




final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    return CompleteProfileScreen(
      email: arguments['email']!,
      password: arguments['password']!,
    );
  },
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  MyAccountScreen.routeName: (context) => MyAccountScreen(),
  MyOrdersScreen.routeName: (context) => MyOrdersScreen(),
  WishlistScreen.routeName: (context) => WishlistScreen(),
  MessageScreen.routeName: (context) => MessageScreen(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
  CheckoutScreen.routeName: (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return CheckoutScreen(
      cartItems: arguments['cartItems'],
      totalPrice: arguments['totalPrice'],
    );
  },
  OrderSuccessScreen.routeName: (context) => OrderSuccessScreen(),
  
  

};  
