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
  // テキストフィールドの入力を管理する
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
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
}
