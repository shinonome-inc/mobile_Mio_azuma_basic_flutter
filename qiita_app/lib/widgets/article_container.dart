import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/widgets/app_bottom_modal_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    Key? key,
    required this.article,
    required this.showAvatar,
  }) : super(key: key);

  final Article article;
  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
          Factory(() => EagerGestureRecognizer())
        };

        UniqueKey key = UniqueKey();

        showAppBottomModalSheet(
          context,
          title: "Article",
          content: WebViewWidget(
            gestureRecognizers: gestureRecognizers,
            key: key,
            controller: WebViewController()
              ..loadRequest(
                Uri.parse(article.url),
              ),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showAvatar) // showAvatarがtrueの場合のみCircleAvatarを表示
                  CircleAvatar(
                    backgroundImage: NetworkImage(article.userIconUrl),
                    radius: 19,
                  ),
                if (showAvatar) // アバターを表示する場合にはスペースも必要
                  const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        article.title,
                        style: AppTextStyles.h2BasicBlack,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '@${article.userName} '
                        '投稿日: ${article.postedDate} '
                        'いいね: ${article.likesCount}',
                        style: AppTextStyles.h3BasicSecondary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: showAvatar ? 16 + 19 * 2 + 8 : 16,
              ),
              const Expanded(
                child: Divider(
                  height: 0,
                  thickness: 0.5,
                  color: AppColors.secondary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
