import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/widgets/searchbar.dart';
import 'package:qiita_app/widgets/text_app_title.dart';

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
    // コンテンツを LayoutBuilder でラップして高さを動的に計算
    return LayoutBuilder(
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
              Container(
                margin: const EdgeInsets.only(
                  top: 48.0,
                  bottom: 4.0,
                ),
                child: TextAppTitle(
                  text: title,
                  // style: style,
                ),
              ),
              if (showSearchBar) const SearchBarWithIcon(),
              if (showBottomDivider) SizedBox(height: dividerHeight),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize {
    // 条件に基づいて高さを動的に計算
    double height = kToolbarHeight; // タイトルのための基本高さ
    if (showSearchBar) height += 56.0; // SearchBar の高さに基づいて調整
    if (showBottomDivider) height += dividerHeight;
    return Size.fromHeight(height);
  }
}
