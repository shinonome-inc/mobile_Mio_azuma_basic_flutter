import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/user.dart';
import 'package:qiita_app/pages/my_page_notlogin.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';
import 'package:qiita_app/widgets/section_divider.dart';
import 'package:qiita_app/widgets/user_info_container.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Article> articles = [];
  User? loggedInUser;
  bool isLoading = true;  // ローディング状態の管理

  @override
  void initState() {
    super.initState();
    fetchLoggedInUserInfo();
  }

  Future<void> fetchLoggedInUserInfo() async {
    setState(() {
      isLoading = true;  // ローディング開始
    });

    try {
      User userInfo = await QiitaRepository.fetchAuthenticatedUserInfo();
      List<Article> userArticles = await QiitaRepository.fetchUserArticles(userInfo.id);

      if (mounted) {
        setState(() {
          loggedInUser = userInfo;
          articles = userArticles;
          isLoading = false;  // ローディング終了
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch user info: $e');
      if (mounted) {
        setState(() {
          isLoading = false;  // エラー時もローディング終了
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        appBar:  AppTitle(title: 'MyPage', showBottomDivider: true),
        body:  Center(child: CircularProgressIndicator()),  // ローディングインジケーターを表示
      );
    } else if (loggedInUser == null) {
      return const MyPageNotLogin();
    } else {
      return Scaffold(
        appBar: const AppTitle(title: 'MyPage', showBottomDivider: true),
        body: Column(
          children: [
            UserInfoContainer(user: loggedInUser!),
            const SectionDivider(text: '投稿記事'),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleContainer(
                    article: articles[index],
                    showAvatar: false,
                    );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
