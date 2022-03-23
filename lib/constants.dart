import 'package:flutter/material.dart';

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
