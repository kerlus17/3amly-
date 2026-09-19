import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeManager {
  static themeData() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.transparent,
      primaryColor: ColorManager.primary800,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.surfaceStrong,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorManager.primary900,
        ),
      ),
    );
  }
}
