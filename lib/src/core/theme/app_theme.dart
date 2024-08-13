import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';




class AppTheme {
  final themeData = ThemeData(
    scaffoldBackgroundColor: backGroundColor,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.epilogue(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: fontColor1
      ),
      titleMedium: GoogleFonts.epilogue(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: fontColor1
      ),
      titleSmall: GoogleFonts.epilogue(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: fontColor1
      ),
      bodyMedium: GoogleFonts.epilogue(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: fontColor1
      ),
      bodySmall: GoogleFonts.epilogue(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: fontColor2
      ),
      labelMedium: GoogleFonts.epilogue(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: fontColor2
      ),
      displayLarge: GoogleFonts.epilogue(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: fontColor1
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: greyColor,
      border: textFieldBorder,
      enabledBorder: textFieldBorder,
      disabledBorder: textFieldBorder,
      hintStyle: const TextStyle(
        color: fontColor2,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    )
  );
}

final textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(color: greyColor),
);