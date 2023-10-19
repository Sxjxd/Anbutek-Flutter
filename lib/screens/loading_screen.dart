import 'package:flutter/material.dart';
import 'package:anbutek_app/screens/splash/splash_screen.dart';

class LoadingScreen extends StatefulWidget {
  static String routeName = "/loading";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2), // Reduced animation duration to 2 seconds
      vsync: this,
    );

    _opacityAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 0.5,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 0.5,
      ),
    ]).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse(); // Reverse the animation when it completes
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward(); // Forward the animation when it starts again
      }
    });

    _animationController.forward();
    loadResources();
  }

  Future<void> loadResources() async {
    await Future.delayed(Duration(seconds: 5)); // Reduced delayed loading resources to 5 seconds
    // Continue loading resources in the background
    navigateToSplashScreen();
        await Future.delayed(Duration(seconds: 8)); 
  }

  void navigateToSplashScreen() {
    Navigator.pushReplacementNamed(context, SplashScreen.routeName);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 74, 173),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Image.asset(
                'assets/images/Anbutek_Loading.png',
                height: 400,
              ),
            );
          },
        ),
      ),
    );
  }
}
