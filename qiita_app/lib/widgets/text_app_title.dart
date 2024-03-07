import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class TextAppTitle extends StatelessWidget {
  final String text;
  final TextStyle style;

  const TextAppTitle({
    Key? key,
    required this.text,
    this.style = const TextStyle(
      fontFamily: 'Pacifico',
      fontSize: 17,
      color: AppColors.black,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
