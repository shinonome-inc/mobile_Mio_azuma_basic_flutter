import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class AppTextStyles {
  static const TextStyle apptitle = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 17,
    color: AppColors.black,
  );
  static const TextStyle h2BasicBlack = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static const TextStyle h3BasicSecondary = TextStyle(
    fontSize: 12,
    color: AppColors.secondary,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle h3BasicBlack = TextStyle(
    fontSize: 12,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle h1ThinBlack = TextStyle(
    fontSize: 17,
    color: AppColors.black,
    fontWeight: FontWeight.w100,
  );
  static const TextStyle h1ThinSecondary = TextStyle(
    fontSize: 17,
    color: AppColors.secondary,
    fontWeight: FontWeight.w400,
  );
}
