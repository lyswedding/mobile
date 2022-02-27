import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/button.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';
import 'package:lys_wedding/authentification/screens/login.dart';

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
          Icons.person,
          color: Color(0xffF2861E),
        ),
        hint: "Enter name",
        controller: personController,
      ),
      CustomInput(
        icon: const Icon(Icons.email, color: Color(0xffF2861E)),
        hint: "Enter Email",
        controller: emailController,
      ),
      CustomInput(
        icon: const Icon(Icons.password, color: Color(0xffF2861E)),
        hint: "Enter Password",
        controller: passwordController,
      ),
      CustomInput(
        icon: const Icon(Icons.password, color: Color(0xffF2861E)),
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
              gradient: LinearGradient(
                  colors: [(new Color(0xffF5591F)), new Color(0xffF2861E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
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
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100, child: Image.asset("images/icon.png")),
              Container(height: 100, child: Image.asset("images/icon.png"))
            ],
          )),
      Container(
        margin: const EdgeInsets.only(top: 10),
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
