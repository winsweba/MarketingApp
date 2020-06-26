import 'package:MarketingApp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static TextStyle get body {
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: AppColors.darkgrey, fontSize: 16.0),
    );
  }

  static TextStyle get suggestions {
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: AppColors.lightgrey, fontSize: 14.0),
    );
  }

  static TextStyle get buttonTextLight {
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
    );
  }

    static TextStyle get buttonTextDark {
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: AppColors.darkgrey, fontSize: 17.0, fontWeight: FontWeight.bold),
    );
  }
}
