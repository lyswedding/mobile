import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/screens/facebook_controller.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/authentification/screens/login_with_facebook.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:provider/provider.dart';
import 'package:lys_wedding/UI/authentification/screens/splash_screen.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/UI/liste/screens/liste_page.dart';
import 'package:lys_wedding/UI/profil/screens/user_lists.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FacebookSignInController(),
            child: Login(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          routes: {
            '/': (context) => SplashScreen(),
            '/signup': (context) => Signup(),
            '/homePage': (context) => Home(),
          },
        ));
  }
}
