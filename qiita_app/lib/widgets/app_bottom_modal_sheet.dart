import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showAppBottomModalSheet(BuildContext context,
    {required String title, required String content}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppBottomModalSheet(title: title, content: content);
      });
}

class AppBottomModalSheet extends StatelessWidget {
  final String title;
  final String content;

  const AppBottomModalSheet({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBottomModalHeader(
              title: title,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: SingleChildScrollView(
                  child: Text(content),
                ),
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

  const AppBottomModalHeader({required this.title, super.key});

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
        // feature/feedpage_article_list_pageのtextstlyes.dartで統合する
        style: const TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 17,
          color: AppColors.black,
        ),
      ),
    );
  }
}
