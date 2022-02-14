import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/component/button.dart';
import 'package:lys_wedding/authentification/component/custom_input.dart';
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
      Container(
          height: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
              color: Colors.orange),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(height: 150, child: Image.asset("images/icon.png")),
                Container(
                  padding: const EdgeInsets.only(right: 30),
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                )
              ]))),
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
