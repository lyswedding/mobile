import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/shared/constants.dart';

void showToast({
  required BuildContext context,
  required String msg,
}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 5),
    builder: (_, controller) {
      return Flash(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        controller: controller,
        backgroundColor: Colors.black87,
        borderRadius: BorderRadius.circular(8.0),
        borderColor: Colors.black87,
        position: FlashPosition.bottom,
        style: FlashStyle.floating,
        alignment: null,
        enableDrag: false,
        onTap: () => controller.dismiss(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Text(
              msg,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    },
  ).then((_) {
    if (_ != null) {
      _showMessage(_.toString(), context);
    }
  });
}

void _showMessage(String message, BuildContext context) {
  showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          position: FlashPosition.top,
          style: FlashStyle.grounded,
          child: FlashBar(
            icon: const Icon(
              Icons.face,
              size: 36.0,
              color: Colors.black,
            ),
            message: Text(message),
          ),
        );
      });
}

//
Widget noDataFound(String text) {
  return Center(
    child: Container(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 40, color: Colors.grey[300]),
      ),
    ),
  );
}

Future<void> showMyDialog(BuildContext context, String title, String message,
    Function onPressed) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Text(
            message,
            textAlign: TextAlign.start,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Continuez'),
            onPressed: onPressed(),
          ),
        ],
      );
    },
  );
}

Future<void> showMyDialogJusrify(BuildContext context, String title,
    String message, Function onPressed) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Text(
            message,
            textAlign: TextAlign.start,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Continuez'),
            onPressed: onPressed(),
          ),
        ],
      );
    },
  );
}

Future<void> createAccountDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Create an account'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Go to Login page',
                    style: subTitleTextStyle,
                  )),
              Text(
                'Would like continue using Lys !! ',
                style: regularTextStyle,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> createAccountDialogue(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Create an account'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Go to Login page',
                    style: subTitleTextStyle,
                  )),
              Text(
                'Would like continue using Lys !! ',
                style: regularTextStyle,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ],
      );
    },
  );
}
