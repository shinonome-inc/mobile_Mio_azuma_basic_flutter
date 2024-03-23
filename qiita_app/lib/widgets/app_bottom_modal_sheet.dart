import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/constants/app_text_style.dart';

void showAppBottomModalSheet(BuildContext context,
    {required String title, required Widget content}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return AppBottomModalSheet(title: title, content: content);
    },
    shape: const RoundedRectangleBorder(
      // 角丸を設定
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
  );
}

class AppBottomModalSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final bool showBottomDivider;

  const AppBottomModalSheet({
    Key? key,
    required this.title,
    required this.content,
    this.showBottomDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      // 初めて描画されるときの高さは画面の90%
      initialChildSize: 0.9,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBottomModalHeader(
              title: title,
            ),
            if (showBottomDivider) // showBottomDividerがtrueの場合にDividerを表示
              const Divider(
                color: AppColors.black,
                thickness: 0.4,
                height: 0.4,
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 18),
                child: content,
              ),
            ),
          ],
        );
      },
    );
  }
}

class AppBottomModalHeader extends StatelessWidget {
  final String title;

  const AppBottomModalHeader({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 11),
      height: 56,
      decoration: const BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Text(
        title,
        style: AppTextStyles.apptitle, // 新しく定義したスタイルを使用
      ),
    );
  }
}
