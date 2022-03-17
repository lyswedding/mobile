import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as path;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/services/auth.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/remove_focuse.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
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
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                  width: 200,
                ),
                CommonTextFieldView(
                  controller: emailController,
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  titleText: 'email',

                  hintText:
                  "enter your email",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String txt) {},
                  focusNode: emailFocusNode,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextFieldView(
                  controller: passwordController,
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  titleText: 'password',

                  hintText:
                  "enter your password",
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (String txt) {},
                  isObscureText: true,
                  focusNode: passFocusNode,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: "Login",
                    onPressed: () {
                      setState(() {
                        isInCall = true;
                      });
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showToast(
                            context: context,
                            msg: 'Merci de remplir tous les champs !');

                      } else if (!isEmail(emailController.text)) {
                        showToast(
                            context: context,
                            msg: 'Format d\'email invalide!');
                      } else if (passwordController.text.length < 6) {
                        showToast(
                            context: context,
                            msg:

                            "Mot de passe doit être d'au moins 6 caractères");
                      }else {
                        var body = {
                          "email": emailController.text,
                          "password": passwordController.text,
                        };
                        print(body.toString());

                        AuthCalls.login(body).then((code) {
                          setState(() {
                            isInCall = false;
                          });
                          if (code.statusCode == 200) {
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
                      }

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
                    InkWell(
                      child: Container(
                          height: 70,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Image.asset("images/21.png")),
                      onTap: SignIn,
                    ),
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
                      Text(
                        "Don't Have Any Account?  ",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.black),
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.pink,
                              decoration: TextDecoration.underline),
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
        ),
      ),
    );
  }

  Future SignIn() async {
    final user = await GoogleSingnInApi.login();
    print(user);
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign in failed")));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }
}

class GoogleSingnInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}
