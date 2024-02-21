import 'package:flutter/cupertino.dart';
import 'package:qiita_app/constants/app_colors.dart';

import '../models/tags.dart';

class TagContainer extends StatelessWidget {
  const TagContainer({
    Key? key,
    required this.tag,
  }) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
        children: [
          Image.network(tag.iconUrl),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(tag.id),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '記事件数:${tag.itemsCount}',
              style: const TextStyle(fontSize: 16, color: AppColors.secondary),
            ),
          ),
          Text(
            'フォロワー数:${tag.followersCount}',
            style: const TextStyle(fontSize: 16, color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
