import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  } else if (value.length < 5) {
    return 'Email must be at least 5 characters long';
  } else if (!value.contains("@")) {
    return 'Invalid email format';
  }
  return null;
}

String? validateNickname(String? value) {
  if (value == null || value.isEmpty) {
    return "Nickname cannot be empty";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}




