import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}

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
      tileColor: Colors.white,
      title: Text(title),
      trailing: showArrow ? const Icon(Icons.arrow_forward_ios) : null,
      onTap: onTap,
    );
  }
}

class CustomDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double indent;

  const CustomDivider({
    Key? key,
    this.color = AppColors.divider,
    this.height = 1.0,
    this.indent = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: height,
      indent: indent,
    );
  }
}
