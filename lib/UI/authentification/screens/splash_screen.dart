import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/connectivity_indicator.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkIfTokenExists();

    super.initState();
  }

  checkIfTokenExists() async {
    await getUserInfoSharedPref("token").then((token) async {
      if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
              settings: const RouteSettings(name: "/homePage"),
            ),
          );
      }else{
        Future.delayed(
            const Duration(seconds: 10),
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home(),
              settings: const RouteSettings(name: '/homePage')),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashscreenColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('images/splashScreen.png'),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            child: RichText(
              text: TextSpan(
                text: 'Lys\n',
                style: GoogleFonts.poppins(
                    fontSize: 48,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Votre meilleure\norganisateur de marriage',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: primaryColor,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
