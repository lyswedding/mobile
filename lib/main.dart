import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/screens/splash_screen.dart';
import 'package:lys_wedding/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/liste/screens/list_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreen(),
    );
  }
}
