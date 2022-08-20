import 'package:flutter/material.dart';
import 'package:homy_app/app/core/values/colors.dart';
import 'package:homy_app/app/core/values/constants.dart';

ThemeData getAppTheme() {
  return ThemeData(
      scaffoldBackgroundColor: white,
      primaryColor: primaryBlue,
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: textColor,
        ),
        titleTextStyle: TextStyle(
          fontFamily: FontContstants.urbanistSemiBold,
          fontSize: 16.0,
          color: textColor,
        ),
      ),
      //bottomnav bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primaryBlue,
        unselectedItemColor: hintColor,
        
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontFamily: FontContstants.urbanistRegular,
            fontSize: 16.0,
            color: white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          primary: primaryBlue,
        ),
      ),
      //text theme
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontFamily: FontContstants.urbanistBold,
          fontSize: 24.0,
          color: textColor,
        ),
        headline5: TextStyle(
          fontFamily: FontContstants.urbanistBold,
          fontSize: 16.0,
          color: textColor,
        ),
        headline4: TextStyle(
          fontFamily: FontContstants.urbanistSemiBold,
          fontSize: 14.0,
          color: textColor,
        ),
        headline3: TextStyle(
          fontFamily: FontContstants.urbanistSemiBold,
          fontSize: 12.0,
          color: textColor,
        ),
        subtitle1: TextStyle(
          fontFamily: FontContstants.urbanistSemiBold,
          fontSize: 12.0,
          color: textColor,
        ),
        subtitle2: TextStyle(
          fontFamily: FontContstants.urbanistRegular,
          fontSize: 16.0,
          color: textColor,
        ),
        bodyText1: TextStyle(
          fontFamily: FontContstants.urbanistRegular,
          fontSize: 12.0,
          color: textColor,
        ),
        bodyText2: TextStyle(
          fontFamily: FontContstants.urbanistRegular,
          fontSize: 14.0,
          color: textColor,
        ),
        caption: TextStyle(
          fontFamily: FontContstants.urbanistRegular,
          fontSize: 12.0,
          color: hintColor,
        ),
      ),
      //input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        hintStyle: const TextStyle(
            color: hintColor,
            fontFamily: FontContstants.urbanistRegular,
            fontSize: 12.0),
        labelStyle: const TextStyle(
            color: textColor,
            fontFamily: FontContstants.urbanistRegular,
            fontSize: 12.0),
        errorStyle: const TextStyle(
            color: redColor,
            fontFamily: FontContstants.urbanistRegular,
            fontSize: 12.0),

        // enabled border
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryLight, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        // focused border
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryBlue, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        // error border
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: redColor, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),

        // error border
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryBlue, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ));
}
