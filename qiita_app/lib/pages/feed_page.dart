import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/services/articles_paginator.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';

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
        fetchArticlesCallback: (page) => QiitaRepository.fetchQiitaItems(
            query: _searchController.text, page: page),
        onDataUpdated: () => setState(() {}));
    articlesPaginator.fetchArticles();
  }

  @override
  void dispose() {
    _searchController.dispose();
    articlesPaginator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitle(
        title: 'Feed',
        showSearchBar: true,
        showBottomDivider: true,
        searchController: _searchController,
        onSearch: (query) {
          articlesPaginator.currentPage = 1;
          articlesPaginator.fetchArticles();
        },
      ),
      body: Builder(builder: (context) {
        if (articlesPaginator.isLoading && articlesPaginator.articles.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (articlesPaginator.articles.isEmpty &&
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
        } else {
          return ListView.builder(
            controller: articlesPaginator.scrollController,
            itemCount: articlesPaginator.articles.length,
            itemBuilder: (context, index) {
              return ArticleContainer(
                article: articlesPaginator.articles[index],
              );
            },
          );
        }
      }),
    );
  }
}
