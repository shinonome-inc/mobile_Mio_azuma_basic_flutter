import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app/models/tags.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/services/articles_paginator.dart'; // パスを適宜調整してください
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';
import 'package:qiita_app/widgets/section_divider.dart';

class TagDetailListPage extends StatefulWidget {
  final Tag tag;

  const TagDetailListPage({
    super.key,
    required this.tag,
  });

  @override
  State<TagDetailListPage> createState() => _TagDetailListPageState();
}

class _TagDetailListPageState extends State<TagDetailListPage> {
  late final ArticlesPaginator articlesPaginator;

  @override
  void initState() {
    super.initState();
    articlesPaginator = ArticlesPaginator(
        fetchArticlesCallback: (page) =>
            QiitaRepository.fetchArticlesByTag(widget.tag.id, page),
        onDataUpdated: () => setState(() {}) // データ更新時にUIを更新
        );
    articlesPaginator.fetchArticles();
  }

  @override
  void dispose() {
    articlesPaginator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitle(
        title: widget.tag.id,
        showSearchBar: false,
        showBottomDivider: true,
        showReturnIcon: true,
      ),
      body: Builder(builder: (context) {
        if (articlesPaginator.isLoading && articlesPaginator.articles.isEmpty) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return Column(
            children: [
              const SectionDivider(text: '投稿記事'),
              Expanded(
                child: ListView.builder(
                  controller: articlesPaginator.scrollController,
                  itemCount: articlesPaginator.articles.length,
                  itemBuilder: (context, index) {
                    return ArticleContainer(
                      article: articlesPaginator.articles[index],
                      showAvatar: true,
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
