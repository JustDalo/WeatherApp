import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:weather_application/controls/FontColorController.dart';
import 'package:weather_application/controls/FontSizeController.dart';
import 'package:weather_application/screens/Home.dart';
import 'package:weather_application/screens/splash_screen/SplashScreen.dart';
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
          title: 'Weather Application',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Stack(children: <Widget>[
      const TabBarPage(),
      IgnorePointer(
          child: SplashScreen(color: Theme.of(context).colorScheme.secondary))
    ]));
  }
}
