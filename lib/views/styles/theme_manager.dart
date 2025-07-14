import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_app/views/styles/color_manager.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: ColorManager.darkBlue,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.darkBlue,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,),
      ),
    );
  }
}
