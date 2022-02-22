import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:weather_application/screens/Home.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            AnimatedSplashScreen(
              duration: 2000,
              splash: Icons.accessible_forward_outlined,
              nextScreen: const MyHomePage(title: 'Home'),
              splashTransition: SplashTransition.sizeTransition,
              pageTransitionType: PageTransitionType.bottomToTop,
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text("Created by Daniil Shyshla"),
            )
          ],
        ));
  }
}
