/*
 * *
 *  * Created by Vishal Patolia on 9/20/21, 5:09 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  * Sdreatech Solutions Pvt. Ltd.
 *  * Last modified 9/20/21, 4:46 PM
 *
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';
import '../values/dimens.dart';

final Widget scaffoldBg = Container(
  decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Colors.black, Colors.black])),
);

final appBarStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontSize: textSizeLargeMedium,
  fontWeight: FontWeight.bold,
);

final hintTextStyle = GoogleFonts.poppins(
  color: Colors.grey.withOpacity(0.9),
  fontSize: textSizeSMedium,
  fontWeight: FontWeight.normal,
);

final errorTextStyle = GoogleFonts.roboto(
  color: Colors.red,
  fontSize: textSizeSmall,
  fontWeight: FontWeight.normal,
);

//Font Size Tiny and Color White
final tinyNormalTextStyle = GoogleFonts.roboto(
    color: primaryTextColor,
    fontSize: textSizeSmall,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3);
final tinyMediumTextStyle = GoogleFonts.roboto(
    color: primaryTextColor,
    fontSize: textSizeSmall,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3);
final tinyBoldTextStyle = GoogleFonts.roboto(
    color: primaryTextColor,
    fontSize: textSizeSmall,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3);

//Font Size Small and Color White
final smallNormalTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeSMedium,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3);
final smallMediumTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeSMedium,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3);
final smallBoldTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeSMedium,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3);

//Font Size Normal and Color White
final normalTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeMedium,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3);
final mediumTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeMedium,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3);
final boldTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeMedium,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3);

//Font Size Large and Color White
final normalLargeTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeLargeMedium,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3);
final mediumLargeTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeLargeMedium,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3);
final boldLargeTextStyle = GoogleFonts.poppins(
    color: primaryTextColor,
    fontSize: textSizeLargeMedium,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3);
