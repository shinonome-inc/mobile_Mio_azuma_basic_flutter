import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late ScrollController _scrollController; // スクロールコントローラーを追加
  List<Article> articles = [];
  bool isLoading = false; // データ読み込み中かどうかを示すフラグを追加
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // スクロールコントローラーを初期化
    fetchArticles();
    _scrollController.addListener(_scrollListener); // スクロールリスナーを追加
  }

  void fetchArticles() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    List<Article> fetchedArticles =
        await QiitaRepository.fetchQiitaItems(currentPage);
    setState(() {
      articles.addAll(fetchedArticles);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // 最下部にスクロールした時に次のページを読み込む
      currentPage++; // 次のページ番号を更新
      fetchArticles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTitle(
        title: 'Feed',
        showSearchBar: true,
        showBottomDivider: true,
      ),
      body: ListView.builder(
        controller: _scrollController, // スクロールコントローラーを設定
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleContainer(
            article: articles[index],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // スクロールコントローラーを破棄
    super.dispose();
  }
}
