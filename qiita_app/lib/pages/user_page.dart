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
  bool isFetching = false;
  int currentPage = 1;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchUserInfo();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> fetchUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      User userInfo = await QiitaRepository.fetchUserInfo(widget.userId);
      List<Article> userArticles = await QiitaRepository.fetchUserArticles(
          widget.userId,
          page: currentPage);

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

  void _scrollListener() {
    if (!isFetching &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      currentPage++;
      fetchUserArticles();
    }
  }

  Future<void> fetchUserArticles() async {
    setState(() {
      isFetching = true;
    });

    try {
      List<Article> additionalArticles =
          await QiitaRepository.fetchUserArticles(widget.userId,
              page: currentPage);

      if (mounted) {
        setState(() {
          articles.addAll(additionalArticles);
          isFetching = false;
        });
      }
    } catch (e) {
      debugPrint('Failed to fetch additional user articles: $e');
      if (mounted) {
        setState(() {
          isFetching = false;
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
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchUserInfo();
        },
        child: Column(
          children: [
            if (loggedInUser != null) UserInfoContainer(user: loggedInUser!),
            const SectionDivider(text: '投稿記事'),
            Expanded(
              child: ListView.builder(
                physics:
                    const AlwaysScrollableScrollPhysics(), //スクロールビューが常にスクロール可能
                itemCount: articles.length + 1, // +1 for loading indicator
                itemBuilder: (context, index) {
                  if (index < articles.length) {
                    return ArticleContainer(
                      article: articles[index],
                      showAvatar: false,
                    );
                  } else {
                    return _buildLoadMoreIndicator();
                  }
                },
                controller: _scrollController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Center(
      child: isFetching ? const CircularProgressIndicator() : const SizedBox(),
    );
  }
}
