import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:path_provider/path_provider.dart';

bool isEmail(String string) {
  // Null or empty string is invalid
  if (string == null || string.isEmpty) {
    return false;
  }

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('images/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future checkIfTokenExists(Function function, BuildContext context) async {
  await getUserInfoSharedPref("token").then((token) async {
    if (token != null) {
      function();
    } else {
      createAccountDialog(context);
    }
  });
}

Future checkIfTokenExist(Function function, BuildContext context) async {
  await getUserInfoSharedPref("token").then((token) async {
    if (token != null) {
      function();
    } else {
      createAccountDialogue(context);
    }
  });
}
