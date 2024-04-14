import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/user.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';
import 'package:qiita_app/widgets/network_error.dart';
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
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchLoggedInUserInfo();
  }

  Future<void> fetchLoggedInUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      User userInfo = await QiitaRepository.fetchAuthenticatedUserInfo();
      List<Article> userArticles =
          await QiitaRepository.fetchUserArticles(userInfo.id);

      if (mounted) {
        setState(() {
          loggedInUser = userInfo;
          articles = userArticles;
          isLoading = false;
          hasError = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch user info: $e');
      if (mounted) {
        setState(() {
          loggedInUser = null;
          isLoading = false;
          hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        appBar: AppTitle(title: 'MyPage', showBottomDivider: true),
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (hasError) {
      return Scaffold(
        appBar: const AppTitle(title: 'MyPage', showBottomDivider: true),
        body: NetworkError(
          onPressReload: () {
            setState(() {
              hasError = false;
            });
            fetchLoggedInUserInfo();
          },
        ),
      );
    }

    return Scaffold(
      appBar: const AppTitle(title: 'MyPage', showBottomDivider: true),
      body: Column(
        children: [
          if (loggedInUser != null) UserInfoContainer(user: loggedInUser!),
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
