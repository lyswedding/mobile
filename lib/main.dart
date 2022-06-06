import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/screens/facebook_controller.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';

import 'package:lys_wedding/UI/connectivity_indicator.dart';
import 'package:lys_wedding/services/tags.services.dart';
import 'package:lys_wedding/services/task_list.services.dart';

import 'package:provider/provider.dart';

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
          ChangeNotifierProvider(
            create: (context) => ListCalls(),
          ),
          ChangeNotifierProvider(
            create: (context) => TagsServices(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: DemoPage(),
          // routes: {
          //   '/': (context) => SplashScreen(),
          //   '/signup': (context) => Signup(),
          //   '/login': (context) => Login(),
          //   '/homePage': (context) => DemoPage(),
          // },
        ));
  }
}
