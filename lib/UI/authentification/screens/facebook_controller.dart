import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';

class FacebookSignInController with ChangeNotifier {
  Map? userdata;
  login() async {
    var result = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);
    print(result);
    // if (result.status == LoginStatus.success) {
    //   final requestdata =
    //       await FacebookAuth.i.getUserData(fields: "email,name,picture");
    //   userdata = requestdata;
    //   notifyListeners();
  }
}

  // logout() async {
  //   await FacebookAuth.i.logOut();
  //   userdata = null;
  //   notifyListeners();
  // }
// }
