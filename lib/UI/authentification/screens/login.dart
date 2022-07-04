import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/facebook_controller.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/connectivity_indicator.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/models/auth_sm_model.dart';
import 'package:lys_wedding/services/auth.services.dart';
import 'package:lys_wedding/services/auth_sm_service.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/remove_focuse.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  AuthSm? _user;
  AuthSmService authSmService = AuthSmService();
  bool isInCall = false;
  Map _userobj = {};
  bool _isloggedin = false;
  AccessToken? _accessToken;
  UserFbModel? _currentUser;
  @override
  Widget build(BuildContext context) {
    UserFbModel? user = _currentUser;
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
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primaryColor),
                            child: const Text(
                              "<< skeep",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 200,
                ),
                CommonTextFieldView(
                  controller: emailController,
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  titleText: 'email',
                  hintText: "enter your email",
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
                  hintText: "enter your password",
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
                            context: context, msg: 'Format d\'email invalide!');
                      } else if (passwordController.text.length < 6) {
                        showToast(
                            context: context,
                            msg:
                                "Mot de passe doit être d'au moins 6 caractères");
                      } else {
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
                                builder: (context) => DemoPage(),
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
                          width: 70,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: const Icon(
                            EvaIcons.google,
                            size: 42,
                          )),
                      onTap: SignIn,
                    ),
                    const Padding(padding: const EdgeInsets.all(20)),
                    InkWell(
                        child: Container(
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
                        onTap: () {
                          if (Provider.of<FacebookSignInController>(context,
                                      listen: false)
                                  .login() ==
                              true) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DemoPage(),
                                ));
                          }
                        })
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
                          Navigator.pushReplacement(
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
    final y = await authSmService.authGoogles(user!.email, user.displayName!,
        user.photoUrl ?? '', user.serverAuthCode);

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: const Text("Sign in failed")));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  Future SignInFb() async {
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      print(value.message);
      print(value.accessToken);
      print(value.status);
      FacebookAuth.instance.getUserData().then((userdata) {
        setState(() {
          _isloggedin = false;
          _userobj = userdata;
        });
      });
    });

    // print(result.accessToken);
    // print(result.status);
    // if (result.status == LoginStatus.success) {
    //   _accessToken = result.accessToken;
    //   final data = await FacebookAuth.i.getUserData();
    //   UserFbModel model = UserFbModel.fromJson(data);
    //   _currentUser = model;
    //   setState(() {});
    // }
  }

  test() async {
    print("aaaaaaaaaaaaaa");
  }

  loginUI() {
    return Consumer<FacebookSignInController>(builder: (context, model, child) {
      if (model.userdata != null) {
        return Center(
          child: loggedInUI(model),
        );
      } else {
        return loginControls(context);
      }
    });
  }

  loggedInUI(FacebookSignInController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // CircleAvatar(
        //   backgroundImage: Image.network(model.userdata.),
        // )
        Text(model.userdata!["name"] ?? ''),
        Text(model.userdata!["email"] ?? '')
      ],
    );
  }

  loginControls(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            child: Image.asset("images/22.png"),
            onTap: () {
              Provider.of<FacebookSignInController>(context, listen: false)
                  .login();
            },
          )
        ],
      ),
    );
  }
}

class GoogleSingnInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class GoogleSingnOutApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();
}

class UserFbModel {
  final String? email;
  final String? id;
  final String? name;
  final PictureModel? pictureModel;
  const UserFbModel({this.email, this.id, this.name, this.pictureModel});
  factory UserFbModel.fromJson(Map<String, dynamic> json) => UserFbModel(
      email: json['email'],
      id: json['id'] as String?,
      name: json['name'],
      pictureModel: PictureModel.fromJson(json['picture']['data']));
}

class PictureModel {
  final String? Url;
  final int? width;
  final int? height;
  const PictureModel({this.Url, this.height, this.width});

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
      Url: json['Url'], height: json['height'], width: json['width']);
}
