import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class RoundedEdgeButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double elevation;

  const RoundedEdgeButton({
    Key? key,
    required this.text,
    this.backgroundColor = AppColors.darkgreen,
    this.textColor = AppColors.white,
    required this.onPressed,
    this.elevation = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity, // 横幅をいっぱいにする
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
