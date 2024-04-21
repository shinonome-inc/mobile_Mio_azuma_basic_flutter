import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';

class ArticlesPaginator {
  ScrollController scrollController = ScrollController();
  List<Article> articles = [];
  bool isLoading = false;
  int currentPage = 1;
  final Function fetchArticlesCallback;
  final VoidCallback onDataUpdated;
  bool hasNetworkError = false;
  bool isSearching = false; // 検索中かどうかを示すフラグ
  late VoidCallback retry;

  ArticlesPaginator({
    required this.fetchArticlesCallback,
    required this.onDataUpdated,
  }) {
    scrollController.addListener(_scrollListener);
    retry = () {
      fetchArticles(isPagination: true);
    };
  }

  void dispose() {
    scrollController.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading &&
        !isSearching) {
      // 検索中ではない場合にのみ実行する
      currentPage++;
      fetchArticles();
    }
  }

  Future<void> fetchArticles({bool isPagination = false}) async {
    if (isLoading && !isPagination) return;
    isLoading = true;

    try {
      List<Article> fetchedArticles = await fetchArticlesCallback(currentPage);
      if (currentPage == 1 || isPagination) {
        articles.clear();
      }

      // 検索中でない場合のみ記事を追加する
      if (!isSearching) {
        // 重複チェック
        for (var article in fetchedArticles) {
          if (!articles.contains(article)) {
            articles.add(article);
          }
        }
      }

      hasNetworkError = false;
    } catch (e) {
      hasNetworkError = true;
    } finally {
      isLoading = false;
      onDataUpdated();
    }
  }

  // 検索状態を更新するメソッド
  void updateSearchState(bool searching) {
    isSearching = searching;
  }
}
