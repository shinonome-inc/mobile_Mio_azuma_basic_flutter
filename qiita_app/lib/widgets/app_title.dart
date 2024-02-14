import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/widgets/searchbar.dart';
import 'package:qiita_app/widgets/text_app_title.dart';

class AppTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? style;
  final Color backgroundColor;
  final Color dividerColor;
  final double dividerHeight;
  final bool showBottomDivider;
  final bool showSearchBar;

  const AppTitle({
    Key? key,
    required this.title,
    this.style,
    this.backgroundColor = AppColors.background,
    this.dividerColor = AppColors.divider,
    this.dividerHeight = 1.0,
    this.showBottomDivider = true,
    this.showSearchBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.divider,
              width: 0.2,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 44.0),
              child: TextAppTitle(
                text: title,
              ),
            ),
            if (showSearchBar) const SearchBarWithIcon(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight +
            (showSearchBar ? 36 : 0) +
            (showBottomDivider ? dividerHeight : 0),
      ); // AppBarの高さ + 区切り線の高さ
}
