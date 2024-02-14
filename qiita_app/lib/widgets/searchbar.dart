import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class SearchBarWithIcon extends StatelessWidget {
  const SearchBarWithIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 54,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(
            fontSize: 17,
          ),
          fillColor: AppColors.gray,
          filled: true,
          prefixIcon: const Padding(
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.search,
              color: AppColors.secondary,
              size: 20,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}
