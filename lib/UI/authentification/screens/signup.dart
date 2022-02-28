import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

TextEditingController personController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return signupwidget();
  }

  Widget signupwidget() {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Container(height: 100, child: Image.asset("images/icon.png")),
          // Container(
          //     height: 300,
          //     decoration: const BoxDecoration(
          //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
          //         color: Colors.orange),
          //     child: Center(
          //         child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //           Container(height: 150, child: Image.asset("images/icon.png")),
          //           Container(
          //             padding: const EdgeInsets.only(right: 30),
          //             alignment: Alignment.bottomRight,
          //             child: const Text(
          //               "Register",
          //               style: TextStyle(fontSize: 40, color: Colors.white),
          //             ),
          //           )
          //         ]))),
          CustomInput(
            icon: const Icon(
              Icons.person_outline,
              color: Color(0xff2D323D),
            ),
            hint: "Enter name",
            controller: personController,
          ),
          CustomInput(
            icon: const Icon(Icons.email_outlined, color: Color(0xff2D323D)),
            hint: "Enter Email",
            controller: emailController,
          ),
          CustomInput(
            icon: const Icon(Icons.https_outlined, color: Color(0xff2D323D)),
            hint: "Enter Password",
            controller: passwordController,
          ),
          CustomInput(
            icon: const Icon(Icons.https_outlined, color: Color(0xff2D323D)),
            hint: "Confirm Password",
            controller: passwordController,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(Icons.check_box_outline_blank),
                Text(
                  "I agree to terms of service and privacy policy",
                )
              ],
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF2D323D),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: CustomButton(
                    text: "Register",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    })),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 8.0,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'or continue with ',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 8.0,
                    ),
                  )
                ],
              )),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 70,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Image.asset("images/21.png")),
              Padding(padding: EdgeInsets.all(20)),
              Container(
                  height: 70,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Image.asset("images/22.png")),
            ],
          )),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("I Have Already "),
              GestureDetector(
                child: const Text(
                  "Login Now",
                  style: TextStyle(color: Colors.orange),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
              )
            ]),
          ),
        ])));
  }
}
