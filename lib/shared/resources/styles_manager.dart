import 'package:flutter/material.dart';
import 'font_manager.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  Color color,
  FontWeight fontWeight,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

// regular fontstyle
TextStyle getRegularStyle({
  fontSize = FontSize.s14,
  required Color color,
  fontWeight = FontWeightManager.normal,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    color,
    fontWeight,
  );
}

TextStyle getHeadingStyle({fontSize = FontSize.s40, required color}) {
  return TextStyle(
    fontWeight: FontWeightManager.bold,
    height: 0.8,
    fontSize: fontSize,
    color: color,
  );
}

TextStyle getHeadingStyle2({fontSize = FontSize.s30, required color}) {
  return TextStyle(
    fontWeight: FontWeightManager.extraBold,
    fontSize: fontSize,
    color: color,
  );
}

// light fontstyle
TextStyle getLightStyle({
  fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    color,
    FontWeightManager.light,
  );
}

// bold fontstyle
TextStyle getBoldStyle({
  fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    color,
    FontWeightManager.bold,
  );
}

// medium fontstyle
TextStyle getMediumStyle({
  fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    color,
    FontWeightManager.medium,
  );
}

// For Therapist Notes

final List<Color> cardsColor = [
  Colors.white,
  Colors.red.shade100,
  Colors.pink.shade100,
  Colors.orange.shade100,
  Colors.yellow.shade100,
  Colors.green.shade100,
  Colors.blue.shade100,
  Colors.blueGrey.shade100,
];

final TextStyle mainTitle =
    GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold);

final TextStyle mainContent =
    GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.normal);

final TextStyle dateTitle =
    GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500);
