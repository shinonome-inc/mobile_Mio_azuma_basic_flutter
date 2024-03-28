import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/constants/app_text_style.dart';

class SectionDivider extends StatelessWidget {
  final String text;
  final Color color;
  final double height;

  const SectionDivider({
    Key? key,
    required this.text,
    this.color = AppColors.divider,
    this.height = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      height: height,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppTextStyles.h3BasicSecondary,
          ),
        ],
      ),
    );
  }
}
