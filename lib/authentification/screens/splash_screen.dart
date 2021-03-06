import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/authentification/screens/intro-screen.dart';
import 'package:lys_wedding/constants.dart';
import 'package:lys_wedding/home/screens/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 5),
            () =>
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) =>  IntroScreen()))
            );
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
