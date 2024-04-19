import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/user.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';
import 'package:qiita_app/widgets/network_error.dart';
import 'package:qiita_app/widgets/section_divider.dart';
import 'package:qiita_app/widgets/user_info_container.dart';

class UserPage extends StatefulWidget {
  final String userId;

  const UserPage({required this.userId, Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Article> articles = [];
  User? loggedInUser;
  bool isLoading = true;
  bool hasNetworkError = false;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      User userInfo = await QiitaRepository.fetchUserInfo(widget.userId);
      List<Article> userArticles =
          await QiitaRepository.fetchUserArticles(widget.userId);

      if (mounted) {
        setState(() {
          loggedInUser = userInfo;
          articles = userArticles;
          isLoading = false;
          hasNetworkError = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch user info: $e');
      if (mounted) {
        setState(() {
          loggedInUser = null;
          isLoading = false;
          hasNetworkError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        appBar: AppTitle(
          title: 'UserPage',
          showBottomDivider: true,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (hasNetworkError) {
      return Scaffold(
        appBar: const AppTitle(title: 'UserPage', showBottomDivider: true),
        body: NetworkError(
          onPressReload: () {
            setState(() {
              hasNetworkError = false;
            });
            fetchUserInfo();
          },
        ),
      );
    }
    return Scaffold(
      appBar: const AppTitle(
        title: 'UserPage',
        showBottomDivider: true,
        showReturnIcon: true,
      ),
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
