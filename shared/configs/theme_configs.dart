import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    useMaterial3: false,
    primaryColor: AppColor.primaryWhite,
    scaffoldBackgroundColor: AppColor.primaryWhite,
    fontFamily: GoogleFonts.inter().fontFamily,
    primarySwatch: getMaterialColor(
      AppColor.primaryTextColor,
    ),
  );

  static MaterialColor getMaterialColor(Color color) {
    final Map<int, Color> shades = {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1),
    };
    return MaterialColor(color.value, shades);
  }

  static TextStyle primaryTextStyle({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColor.primaryTextColor,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    double? height,
    double letterSpacing = 0.0,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      shadows: shadows,
      decoration: decoration ?? TextDecoration.none,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

class AppColor {
  static const Color primaryGreen = Color(0xFFCAF9D7);
  static const Color primaryTextColor = Color(0xFF5F6F7C);
  static const Color primaryGrey = Color(0xFFEFF2F7);
  static const Color extraDarkGrey = Color(0xFF76899A);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryLightBlue = Color(0xFFF1F6FB);
  static const Color darkGrey = Color(0xFFD0D0D0);
  static const Color lightGrey = Color.fromARGB(255, 235, 235, 235);
  static const Color extraLightGrey = Color.fromARGB(255, 242, 242, 242);
  static const Color buttonShadowColor = Color(0xFFDBEEFF);
  static const Color darkGreen = Color(0xFF179E49);
  static const Color sageGreen = Color(0xFF98BE9E);
  static const Color brightGreen = Color(0xFF00A94F);
  static const Color lightGreyTextColor = Color(0xFFACB3BA);
  static const Color lightBackgroundGrey = Color(0xFFF6F8FA);
  static const Color darkBlue = Color(0xFF324A5E);
  static const Color ceruleanBlue = Color(0xFF1F7FB1);
  static const Color lightBlue = Color(0xFF248CED);
  static const Color primaryRed = Color(0xFFD64526);
  static const Color lightRed = Color(0xFFF9CACA);
  static const Color brightRed = Color(0xFFFC0606);
  static const Color primaryYellow = Color(0xFFFABC27);
  static const Color lightYellow = Color(0xFFFFF3D6);
  static const Color softGrey = Color(0xFFEFEFF0);
  static const Color silverGrey = Color(0xFFC5C5C5);
  static Color dialogBarrierColor = const Color(0xFF606060).withOpacity(0.5);
}

class AppTransition {
  static const Duration popupAnimationDuration = Duration(milliseconds: 200);
}
