import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_text_style.dart';
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
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  List<Article> articles = [];
  bool isLoading = false; // データ読み込み中かどうかを示すフラグを追加
  int currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchArticles();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void fetchArticles({String query = ''}) async {
    if (isLoading) return;
    setState(() {
      _isLoading = true;
      isLoading = true;
    });

    List<Article> fetchedArticles =
        await QiitaRepository.fetchQiitaItems(query: query, page: currentPage);
    setState(() {
      if (currentPage == 1) {
        articles.clear(); // ページ番号が1の場合はリストをクリア
      }
      articles.addAll(fetchedArticles);
      _isLoading = false;
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      // isLoading フラグをチェックして新しいリクエストを行わないようにする
      // 最下部にスクロールした時に次のページを読み込む
      currentPage++; // 次のページ番号を更新
      fetchArticles();
    }
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
          currentPage = 1;
          fetchArticles(query: query);
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
            controller: _scrollController,
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
