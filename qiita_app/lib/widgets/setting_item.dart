import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showArrow;

  const SettingItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.showArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Text(title),
      trailing: showArrow ? const Icon(Icons.arrow_forward_ios) : null,
      onTap: onTap,
    );
  }
}
