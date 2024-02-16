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
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.network(tag.iconUrl),
          Text(tag.id),
          Text(
            '記事件数:${tag.itemsCount}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'フォロワー数:${tag.followersCount}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
