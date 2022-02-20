import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/controls/fontColorController.dart';
import 'package:weather_application/controls/fontSizeController.dart';
import 'package:weather_application/screens/map.dart';
import 'package:weather_application/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weather_application/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FontSizeController()),
          ChangeNotifierProvider(create: (context) => FontColorController())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        ));
  }
}
