import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void showToast({
  required BuildContext context,
  required String msg,
}) {
  showFlash(
    context: context,
    duration: Duration(seconds: 5),
    builder: (_, controller) {
      return Flash(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 100),
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
            style: TextStyle(color: Colors.white),
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
      duration: Duration(seconds: 3),
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
            child: Text('Continuez'),
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
            child: Text('Continuez'),
            onPressed: onPressed(),
          ),
        ],
      );
    },
  );
}
