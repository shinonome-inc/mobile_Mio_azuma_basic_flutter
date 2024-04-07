import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/user.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';
import 'package:qiita_app/widgets/section_divider.dart';
import 'package:qiita_app/widgets/user_info_container.dart';

class MyPage extends StatefulWidget {
  const MyPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Article> articles = [];
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    fetchLoggedInUserInfo();
  }

  Future<void> fetchLoggedInUserInfo() async {
    debugPrint('Starting to fetch logged in user info...');

    try {
      User userInfo = await QiitaRepository.fetchAuthenticatedUserInfo();
      debugPrint('Logged in user info fetched successfully.');

      List<Article> userArticles = await QiitaRepository.fetchUserArticles(userInfo.id);

      setState(() {
        loggedInUser = userInfo;
        articles = userArticles;  // ユーザーの記事リストを更新
      });
    } catch (e) {
      debugPrint('Failed to fetch user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTitle(
        title: 'MyPage',
        showBottomDivider: true,
      ),
      body: Column(
        children: [
          if (loggedInUser != null) ...[
            UserInfoContainer(
              user: loggedInUser!,
            )
          ] else ...[
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://unsplash.it/630/400'),
                  radius: 40,
                ),
                SizedBox(height: 16),
                Text(
                  'username',
                  style: AppTextStyles.h2BasicBlack,
                ),
                SizedBox(height: 4),
                Text(
                  '@userID',
                  style: AppTextStyles.h3BasicSecondary,
                ),
                Text(
                  'User Description User Description User Description User Description',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text('100フォロー'),
                Text('100フォロワー'),
              ],
            ),
          ],
          const SectionDivider(text: '投稿記事'),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleContainer(
                  article: articles[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

