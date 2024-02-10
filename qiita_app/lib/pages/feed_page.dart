import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/article_container.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  List<Article> articles = [];
  void fetchArticles() async {
    // QiitaRepositoryから記事データを非同期で取得
    List<Article> fetchedArticles = await QiitaRepository.fetchQiitaItems();
    // 取得した記事データをステートにセット
    setState(() {
      articles = fetchedArticles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleContainer(article: articles[index]);
        },
      ),
    );
  }
}
