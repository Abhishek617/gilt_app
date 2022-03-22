import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class
  static const cream_app = const Color(0xFFffe8d2);
  static const orange_app = const Color(0xFFf37024);
  static const mauve_app = const Color(0xFF9D2167);

  static const Map<int, Color> cream = const <int, Color>{
    50: cream_app,
    100: const Color(0xFFffe8d2),
    200: const Color(0xFFffe8d2),
    300: const Color(0xFFffe8d2),
    400: const Color(0xFFffe8d2),
    500: const Color(0xFFcb4500),
    600: const Color(0xFFc83800),
    700: const Color(0xFFc22200),
    800: const Color(0xFFba0000),
    900: const Color(0xFFaf0000)
  };
  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFfff7e2),
    100: const Color(0xFFf37024),
    200: const Color(0xFFf37024),
    300: const Color(0xFFf37024),
    400: const Color(0xFFf37024),
    500: const Color(0xFFf37024),
    600: const Color(0xFFf37024),
    700: const Color(0xFFf37024),
    800: const Color(0xFFf37024),
    900: orange_app
  };
  static const Map<int, Color> mauve = const <int, Color>{
    50: const Color(0xFFff4f94),
    100: const Color(0xFFff4f94),
    200: const Color(0xFFff4f94),
    300: const Color(0xFFff4f94),
    400: const Color(0xFFff4f94),
    500: const Color(0xFFc42870),
    600: const Color(0xFFc42870),
    700: const Color(0xFFc42870),
    800: const Color(0xFFc42870),
    900: mauve_app
  };
  static const pageBackgroundColour = cream_app;
  static final primaryColour = mauve_app;
  static final buttonColour = primaryColour;
  static const buttonTextColour = const Color(0xFFffffff);
}
