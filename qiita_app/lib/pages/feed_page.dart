import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/article_container.dart';
import 'package:flutter/cupertino.dart';

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
  // テキストフィールドの入力を管理する
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

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
    
  @override
  void dispose() {
    _searchController.dispose(); // ウィジェットが破棄される際にTextEditingControllerをクリーンアップ
    super.dispose();
  }

  List<Article> articles = [];

  void fetchArticles({String query = ''}) async {
    setState(() {
      _isLoading = true; // ローディング開始
    });

    // QiitaRepositoryから記事データを非同期で取得
    List<Article> fetchedArticles =
        await QiitaRepository.fetchQiitaItems(query: query);
    // 取得した記事データをステートにセット
    setState(() {
      articles = fetchedArticles;
      _isLoading = false; // ローディング終了
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitle(
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

        searchController: _searchController,
        onSearch: (query) {
          final searchQuery = QiitaRepository.buildQuery(query);
          fetchArticles(query: searchQuery);

        },
      ),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (articles.isEmpty && _searchController.text.isNotEmpty) {
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
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ArticleContainer(
                article: articles[index],
              );
            },
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // スクロールコントローラーを破棄
    super.dispose();
  }
}
