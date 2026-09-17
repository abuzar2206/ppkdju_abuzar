import 'package:flutter/material.dart';
import 'app_assets.dart';

class AppImages {
  static Image google({
    double width = 20,
    double height = 20,
  }) {
    return Image.asset(
      AppAssets.google,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }

  static Image apple({
    double width = 20,
    double height = 20,
  }) {
    return Image.asset(
      AppAssets.apple,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }

  static Image linkedin({
    double width = 150,
    double height = 50,
  }) {
    return Image.asset(
      AppAssets.linkedin,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}