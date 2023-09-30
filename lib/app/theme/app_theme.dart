import 'package:flutter/material.dart';

import '../app.dart';

class AppTheme {
  static ThemeData get darkMode => ThemeData.dark().copyWith(
        // scaffoldBackgroundColor: Colors.black26,
        primaryColor: AppConstants.yellowColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: StylesHelpers.w500(20),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: AppConstants.yellowColor,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppConstants.yellowColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.yellowColor,
            shape: const StadiumBorder(),
            elevation: 0,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: AppConstants.yellowColor),
          iconColor: AppConstants.yellowColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.yellowColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.whiteColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.redColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
      );

  static ThemeData get lightMode => ThemeData.light().copyWith(
        primaryColor: AppConstants.yellowColor,
        scaffoldBackgroundColor: AppConstants.alabastroColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.yellowColor,
          centerTitle: true,
          titleTextStyle: StylesHelpers.w500(
            20,
            AppConstants.darkColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppConstants.darkColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: AppConstants.yellowColor,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppConstants.yellowColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.yellowColor,
            shape: const StadiumBorder(),
            elevation: 0,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: AppConstants.darkColor),
          iconColor: AppConstants.darkColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.darkColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.darkColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.redColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
      );
}
