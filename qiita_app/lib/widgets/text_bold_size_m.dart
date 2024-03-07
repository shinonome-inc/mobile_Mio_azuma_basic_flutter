import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class TextBoldSizeM extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextBoldSizeM({
    Key? key,
    required this.text,
    this.fontSize = 14.0,
    this.color = AppColors.black,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
