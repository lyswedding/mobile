import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/services/auth_sm_service.dart';

class FacebookSignInController with ChangeNotifier {
  AuthSmService authSmService = AuthSmService();
  Map? userdata;
  login() async {
    var result = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);
    print(result.message);
    //print(result.accessToken!.applicationId);
    //print(result.status);
    // authSmService.authfacebook(result.);
    if (result.status == LoginStatus.success) {
      final requestdata =
          await FacebookAuth.i.getUserData(fields: "email,name,picture");
      userdata = requestdata;
      print(userdata!["picture"]);
      // print(userdata);
      final x = await authSmService.authfacebook(
        userdata!["email"],
        userdata!["name"],
        userdata!["picture"]["data"]["url"],
        userdata!["id"],
      );
      print('***********************x******************');
      print(x);
      notifyListeners();
      return true;
    }
  }

  // logout() async {
  //   await FacebookAuth.i.logOut();
  //   userdata = null;
  //   notifyListeners();
  // }
// }
}
