import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/services/articles_paginator.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';
import 'package:qiita_app/widgets/network_error.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final TextEditingController _searchController = TextEditingController();
  late final ArticlesPaginator articlesPaginator;

  @override
  void initState() {
    super.initState();
    articlesPaginator = ArticlesPaginator(
      fetchArticlesCallback: (page) =>
          _fetchArticles(page, _searchController.text),
      onDataUpdated: () => setState(() {}),
    );
    articlesPaginator.fetchArticles();
  }

  @override
  void dispose() {
    _searchController.dispose();
    articlesPaginator.dispose();
    super.dispose();
  }

  Future<List<Article>> _fetchArticles(int page, String query) async {
    return await QiitaRepository.fetchQiitaItems(query: query, page: page);
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchController.text = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitle(
        title: 'Feed',
        showSearchBar: articlesPaginator.articles.isNotEmpty,
        showBottomDivider: true,
        searchController: _searchController,
        onSearch: (query) {
          articlesPaginator.currentPage = 1;
          _updateSearchQuery(query);
          articlesPaginator.fetchArticles();
        },
      ),
      body: Builder(
        builder: (context) {
          if (articlesPaginator.isLoading &&
              articlesPaginator.articles.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (articlesPaginator.articles.isEmpty &&
              _searchController.text.isNotEmpty) {
            return const Center(
              child: Column(
                children: [
                  SizedBox(height: 228),
                  Text(
                    '検索にマッチする記事はありませんでした',
                    style: AppTextStyles.h2BasicBlack,
                  ),
                  SizedBox(height: 18),
                  Text(
                    '検索条件を変えるなどして再度検索をしてください',
                    style: AppTextStyles.h3BasicSecondary,
                  )
                ],
              ),
            );
          }
          if (articlesPaginator.articles.isEmpty &&
              articlesPaginator.hasNetworkError) {
            return NetworkError(
              onPressReload: () {
                setState(() {
                  articlesPaginator.retry();
                });
              },
            );
          }
          return ListView.builder(
            controller: articlesPaginator.scrollController,
            itemCount: articlesPaginator.articles.length,
            itemBuilder: (context, index) {
              return ArticleContainer(
                article: articlesPaginator.articles[index],
                showAvatar: true,
              );
            },
          );
        },
      ),
    );
  }
}
