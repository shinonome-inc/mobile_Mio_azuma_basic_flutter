import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/widgets/searchbar.dart';

class AppTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? style;
  final Color backgroundColor;
  final double dividerHeight;
  final bool showBottomDivider;
  final bool showSearchBar;

  const AppTitle({
    Key? key,
    required this.title,
    this.style,
    this.backgroundColor = AppColors.background,
    this.dividerHeight = 1.0,
    this.showBottomDivider = true,
    this.showSearchBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = Theme.of(context).dividerColor;
    return SafeArea(
      // SafeArea を追加
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: showBottomDivider
                  ? Border(
                      bottom: BorderSide(color: dividerColor, width: 0.2),
                    )
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: style ?? AppTextStyles.apptitle,
                ),
                if (showSearchBar) const SearchBarWithIcon(),
                if (showBottomDivider) SizedBox(height: dividerHeight),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize {
    double height = kToolbarHeight; // 基本高さ
    if (showSearchBar) height += 56.0; // SearchBar の高さ追加
    if (showBottomDivider) height += dividerHeight; // Divider の高さ追加
    return Size.fromHeight(height);
  }
}
