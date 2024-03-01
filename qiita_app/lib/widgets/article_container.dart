import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/models/article.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(article.userIconUrl),
                radius: 19,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: AppTextStyles.h2BasicBlack,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          '＠${article.userName}',
                          style: AppTextStyles.h3BasicSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '投稿日:${article.postedDate}',
                          style: AppTextStyles.h3BasicSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'いいね：${article.likesCount}',
                          style: AppTextStyles.h3BasicSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 16 +
                        19 * 2 +
                        8), // CircleAvatarの直径と左のPadding、そして間のスペースを加算
                child: const Divider(
                  thickness: 0.5,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
