import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/services/auth.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/remove_focuse.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';

class Signup extends StatefulWidget {
  // final _appNavigatorFactory;
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // final _appNavigatorFactory;
  // _SignupState(this._appNavigatorFactory);
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isInCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBGColor,
        body: RemoveFocuse(
          onClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 5, bottom: 10),
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          key: Key("seek"),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: primaryColor),
                          child: Text(
                            "<< skeep",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 200,
                width: 200,
              ),
              CommonTextFieldView(
                key: Key("first name"),
                controller: fnameController,
                padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                titleText: 'first name',
                hintText: "enter_first_name",
                keyboardType: TextInputType.name,
                onChanged: (String txt) {},
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextFieldView(
                key: Key("last name"),
                controller: lnameController,
                padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                titleText: 'last name',
                hintText: "enter last name",
                keyboardType: TextInputType.name,
                onChanged: (String txt) {},
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextFieldView(
                key: Key("email"),
                controller: emailController,
                padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                titleText: 'email',
                hintText: "enter email",
                keyboardType: TextInputType.emailAddress,
                onChanged: (String txt) {},
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextFieldView(
                key: Key("password"),
                controller: passwordController,
                padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                titleText: 'password',
                hintText: "enter password",
                keyboardType: TextInputType.visiblePassword,
                isObscureText: true,
                onChanged: (String txt) {},
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextFieldView(
                key: Key("phone"),
                controller: phoneController,
                padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                titleText: 'phone',
                hintText: "enter phone number",
                keyboardType: TextInputType.number,
                onChanged: (String txt) {},
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: "Register",
                  onPressed: () {
                    if (fnameController.text.isEmpty ||
                        lnameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        phoneController.text.length < 8 ||
                        phoneController.text.length > 13) {
                      showToast(
                          context: context,
                          msg: 'Merci de remplir tous les champs !');
                    } else if (!isEmail(emailController.text)) {
                      showToast(
                          context: context, msg: 'Format d\'email invalide!');
                    } else if (passwordController.text.length < 6) {
                      showToast(
                          context: context,
                          msg:
                              "Mot de passe doit être d'au moins 6 caractères");
                    } else {
                      setState(() {
                        isInCall = true;
                      });

                      var body = {
                        "firstName": fnameController.text,
                        "lastName": lnameController.text,
                        "email": emailController.text,
                        "password": passwordController.text,
                        "phone": phoneController.text,
                      };
                      print(body.toString());

                      AuthCalls.signup(body).then((response) {
                        setState(() {
                          isInCall = false;
                        });
                        if (response.statusCode == 201) {
                          showToast(
                              context: context,
                              msg:
                                  "Utilisateur créé avec succès!\nUtilisez vos informations d'identification pour vous connecter");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        } else {
                          showToast(
                              context: context,
                              msg: jsonDecode(response.body)["message"]);
                        }
                      });
                    }
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
                      width: 70,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: const Icon(
                        EvaIcons.google,
                        size: 42,
                      )),
                  const Padding(padding: EdgeInsets.all(20)),
                  Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: const Icon(
                        Icons.facebook,
                        size: 42,
                      )),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I Have Already ",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            "Login Now",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.pink,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        // } else {
                        //   showToast(
                        //       context: context,
                        //       msg:
                        //           "Une erreur s'est produite. Veuillez réessayer!");
                        // }
                      ])),
            ]),
          )),
        ));
  }
}
