import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/tags.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
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
  List<Article> articles = [];
  late final ScrollController _scrollController;
  bool isLoading = true;
  int currentPage = 1; // 現在のページ番号を追跡

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // initState で ScrollController を初期化
    _scrollController.addListener(_scrollListener);
    fetchArticles();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage++; // 次のページへ
      fetchArticles(isPagination: true);
    }
  }

  void fetchArticles({bool isPagination = false}) async {
    // 初回の読み込みでなければ、ローディング状態を更新しない
    if (isPagination || isLoading) {
      List<Article> fetchArticles =
          await QiitaRepository.fetchArticlesByTag(widget.tag.id, currentPage);
      setState(() {
        articles.addAll(fetchArticles);
        // 初回読み込みの完了後はisLoadingをfalseに設定
        if (!isPagination) {
          isLoading = false;
        }
      });
    }
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
        if (isLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return Column(
            children: [
              const SectionDivider(text: '投稿記事'),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return ArticleContainer(
                      article: articles[index],
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
