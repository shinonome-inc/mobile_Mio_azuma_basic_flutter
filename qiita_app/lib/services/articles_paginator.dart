import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';

class ArticlesPaginator {
  ScrollController scrollController = ScrollController();
  List<Article> articles = [];
  bool isLoading = false;
  int currentPage = 1;
  final Function fetchArticlesCallback;
  final VoidCallback onDataUpdated; // 追加: データ更新時のコールバック

  ArticlesPaginator({
    required this.fetchArticlesCallback,
    required this.onDataUpdated,
  }) {
    scrollController.addListener(_scrollListener);
  }
  void dispose() {
    scrollController.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      currentPage++;
      fetchArticles();
    }
  }

  Future<void> fetchArticles({bool isPagination = false}) async {
    if (isLoading && !isPagination) return;
    isLoading = true;

    List<Article> fetchedArticles = await fetchArticlesCallback(currentPage);
    if (currentPage == 1) {
      articles.clear();
    }
    articles.addAll(fetchedArticles);

    isLoading = false;
    onDataUpdated(); // データ更新後にコールバックを呼び出す
  }
}
