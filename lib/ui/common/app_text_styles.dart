import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static const heading = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const body = TextStyle(fontSize: 15, color: AppColors.textGrey);

  static const button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
