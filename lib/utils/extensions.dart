import 'dart:io';

import 'package:flutter/material.dart';

import '../values/values.dart';



snackBar(BuildContext context, String title, String msg, Color color) {
  final snackBar = SnackBar(
      content:
          Text(msg, style: smallMediumTextStyle.copyWith(color: Colors.white)),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      margin: const EdgeInsets.symmetric(horizontal: 8));
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// hides the keyboard if its already open
hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}
