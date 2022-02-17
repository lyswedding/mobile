import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/screens/login.dart';
import 'package:lys_wedding/authentification/screens/signup.dart';
import 'package:lys_wedding/home/screens/home.dart';

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
      home: Login(),
    );
  }
}
