import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class TextAppTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const TextAppTitle({
    Key? key,
    required this.text,
    this.fontSize = 17.0,
    this.color = AppColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Pacifico',
        fontSize: 17,
        color: AppColors.black,
      ),
    );
  }
}
