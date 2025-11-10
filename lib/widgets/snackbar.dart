import 'package:flutter/material.dart';

showSnack({required BuildContext context, required String message, bool isError = false}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: (isError)? Colors.red : Colors.green,
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
