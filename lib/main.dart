import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/authentification/screens/splash_screen.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/UI/liste/screens/liste_page.dart';
import 'package:lys_wedding/UI/profil/screens/user_lists.dart';


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
      routes: {
        '/': (context) => SplashScreen(),
        '/signup': (context) => Signup(),
        '/homePage': (context) => Home(),
      },
    );
  }
}
