import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/UI/liste/screens/add-lists.dart';
import 'package:lys_wedding/services/auth.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';


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
      backgroundColor: scaffoldBGColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 200,width: 200,),
              CustomInput(
                icon: const Icon(EvaIcons.email, color:secondaryColor),
                hint: 'Enter your email',
                controller: emailController,
              ),
              const SizedBox(height: 15,),
              CustomInput(
                icon: const Icon(EvaIcons.lock, color: secondaryColor),
                hint: "Enter password",
                controller: passwordController,
              ),
              const SizedBox(height: 20,),
              CustomButton(
                  text: "Login",
                  onPressed: () {
                    setState(() {
                      isInCall = true;
                    });

                    var body = {
                      "email": emailController.text,
                      "password": passwordController.text,
                    };
                    print(body.toString());

                    AuthCalls.login(body).then((code) {
                      setState(() {
                        isInCall = false;
                      });
                      if (code == 200) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      } else {
                        showToast(
                            context: context,
                            msg:
                            "Une erreur s'est produite. Veuillez réessayer!");
                      }
                    });
                  }),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                children: <Widget>[
                  const Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 8.0,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'or continue with ',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.black),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                    child:  Divider(
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
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Image.asset("images/21.png")),
                  const Padding(padding: const EdgeInsets.all(20)),
                  Container(
                      height: 70,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Image.asset("images/22.png")),
                ],
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("Don't Have Any Account?  ",style: GoogleFonts.poppins(
                         fontSize: 12, color: Colors.black),),
                    GestureDetector(
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.pink,decoration: TextDecoration.underline),                    ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            ));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
