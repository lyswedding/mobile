import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/component/button.dart';
import 'package:lys_wedding/authentification/component/custom_input.dart';
import 'package:lys_wedding/authentification/screens/signup.dart';
import 'package:lys_wedding/home/screens/homedetails.dart';

import '../../home/screens/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Loginwidget();
  }

  Widget Loginwidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 300,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: Colors.orange),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Container(
                          height: 150, child: Image.asset("images/icon.png")),
                      Container(
                        padding: const EdgeInsets.only(right: 30),
                        alignment: Alignment.bottomRight,
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      )
                    ]))),
            CustomInput(
              icon: Icon(Icons.email, color: Colors.orange),
              hint: 'email',
              controller: emailController,
            ),
            CustomInput(
              icon: const Icon(Icons.person, color: Colors.orange),
              hint: "password",
              controller: passwordController,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: const Text("Forget Password?"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xffF5591F)),
                      new Color(0xffF2861E)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: CustomButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      })),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have Any Account?  "),
                  GestureDetector(
                    child: const Text(
                      "Login Now",
                      style: TextStyle(color: Colors.orange),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup(),
                          ));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
