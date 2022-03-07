import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/services/auth.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

TextEditingController fnameController = TextEditingController();
TextEditingController lnameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController phoneController = TextEditingController();
bool isInCall = false;

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return signupwidget();
  }

  Widget signupwidget() {
    return Scaffold(
        backgroundColor: scaffoldBGColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const SizedBox(
              height: 200,
              width: 200,
            ),
            CustomInput(
              icon: const Icon(EvaIcons.person, color: secondaryColor),
              hint: "Enter first name",
              controller: fnameController,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInput(
              icon: const Icon(EvaIcons.person, color: secondaryColor),
              hint: "Enter last name",
              controller: lnameController,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInput(
              icon: const Icon(EvaIcons.email, color: secondaryColor),
              hint: "Enter Email",
              controller: emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInput(
              icon: const Icon(EvaIcons.lock, color: secondaryColor),
              hint: "Enter Password",
              controller: passwordController,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInput(
              icon: const Icon(EvaIcons.phone, color: secondaryColor),
              hint: "Enter phone number",
              controller: phoneController,
            ),
            // Container(
            //   margin: const EdgeInsets.only(left: 20),
            //   child: Row(
            //     children: const [
            //       Icon(Icons.check_box_outline_blank),
            //       Text(
            //         "I agree to terms of service and privacy policy",
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20,),
            CustomButton(
                text: "Register",
                onPressed: () {
                  setState(() {
                    isInCall = true;
                  });

                  var body = {
                    "firstname": fnameController.text,
                    "lastname": lnameController.text,
                    "email": emailController.text,
                    "password": passwordController.text,
                    "phone": passwordController.text,
                  };
                  print(body.toString());

                  AuthCalls.signup(body).then((code) {
                    setState(() {
                      isInCall = false;
                    });
                    if (code == 200) {
                      showToast(
                          context: context,
                          msg:
                              "Utilisateur créé avec succès!\nUtilisez vos informations d'identification pour vous connecter");
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
                margin: const EdgeInsets.only(top: 20),
                child: Row(
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
                      child: Divider(
                        color: Colors.black,
                        height: 8.0,
                      ),
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 70,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Image.asset("images/21.png")),
                const Padding(padding: EdgeInsets.all(20)),
                Container(
                    height: 70,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Image.asset("images/22.png")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
              "I Have Already ",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                  ),
                  GestureDetector(
              child: Text(
                "Login Now",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.pink,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
              },
                  )
                ]),
            ),
          ]),
        )));
  }
}
