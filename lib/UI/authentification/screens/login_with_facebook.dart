import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'facebook_controller.dart';

class FacebookLogin extends StatefulWidget {
  const FacebookLogin({Key? key}) : super(key: key);

  @override
  State<FacebookLogin> createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("social login"),
        backgroundColor: Colors.redAccent,
      ),
      body: loginUI(),
    );
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
        CircleAvatar(
          backgroundImage: NetworkImage(model.userdata!["picture"]['url']),
        ),
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
