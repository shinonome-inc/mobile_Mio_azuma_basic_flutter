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
  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  List<Article> articles = [];

  void fetchArticles() async {
    List<Article> fetchArticles =
        await QiitaRepository.fetchArticlesByTag(widget.tag.id);
    setState(() {
      articles = fetchArticles;
    });
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
      body: Column(
        children: [
          const SectionDivider(text: '投稿記事'),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleContainer(
                  article: articles[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
