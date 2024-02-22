import 'package:flutter/material.dart';

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
