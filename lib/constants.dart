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
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final snackbar = SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ),
  );

  final controller = scaffoldMessenger.showSnackBar(snackbar);
}

const kDrawerItemStyle = TextStyle(fontSize: 16);

const kBoxShadow = BoxShadow(
  color: Colors.black12,
  blurRadius: 5.0,
  spreadRadius: 0.5,
  offset: Offset(0.7, 0.7),
);
