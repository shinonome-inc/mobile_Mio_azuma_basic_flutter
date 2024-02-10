import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class TextRegularSizeS extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const TextRegularSizeS({
    Key? key,
    required this.text,
    this.fontSize = 12.0,
    this.color = AppColors.secondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
