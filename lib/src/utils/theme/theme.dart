import 'package:flutter/material.dart';
import 'package:food_dashboard/src/utils/theme/widget_theme/outlined_button_theme.dart';
import 'package:food_dashboard/src/utils/theme/widget_theme/text_field_theme.dart';
import 'package:food_dashboard/src/utils/theme/widget_theme/text_theme.dart';

import 'widget_theme/elevated_button_theme.dart';

class TAppTheme {
  TAppTheme._(); //ini untuk private kan class so user tk leh panggil its instance

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
