import 'package:flutter/material.dart';

import 'components/progress_dialog.dart';

Future<dynamic> showLoadingMessage(BuildContext context, String status) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => ProgressDialog(status: status),
  );
}

InputDecoration inputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(fontSize: 14),
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
  final snackbar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ),
  );

  ScaffoldFeatureController controller =
      scaffoldMessenger.showSnackBar(snackbar);
}

String mapKey = 'AIzaSyCB-u6_5tGdyz9C9HGm6ekeRBOrnbutrGs';

const kDrawerItemStyle = TextStyle(fontSize: 16);
