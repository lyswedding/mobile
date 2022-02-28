import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/liste/screens/add-lists.dart';


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
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50, bottom: 10)),
            Container(height: 100, child: Image.asset("images/icon.png")),
            // Container(
            //     height: 300,
            //     decoration: const BoxDecoration(
            //         borderRadius:
            //             BorderRadius.only(bottomLeft: Radius.circular(90)),
            //         color: Colors.orange),
            //     child: Center(
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //           Container(
            //               height: 150, child: Image.asset("images/icon.png")),
            //           Container(
            //             padding: const EdgeInsets.only(right: 30),
            //             alignment: Alignment.bottomRight,
            //             child: const Text(
            //               "Login",
            //               style: TextStyle(fontSize: 40, color: Colors.white),
            //             ),
            //           )
            //         ]))),
            CustomInput(
              icon: Icon(Icons.email_outlined, color: Colors.black),
              hint: 'Enter your email',
              controller: emailController,
            ),
            CustomInput(
              icon: const Icon(Icons.lock_outline, color: Colors.black),
              hint: "Enter password",
              controller: passwordController,
            ),

            GestureDetector(
              onTap: () {},
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (new Color(0xffF5591F)),
                      new Color(0xffF2861E)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddList()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Row(
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
            ),
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
