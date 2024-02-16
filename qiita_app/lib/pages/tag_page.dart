import 'package:flutter/material.dart';
import 'package:qiita_app/models/tags.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/tag_container.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  @override
  void initState() {
    super.initState();
    fetchTags();
  }

  List<Tag> tags = [];
  void fetchTags() async {
    List<Tag> fetchedTags = await QiitaRepository.fetchQiitaTags();
    setState(
      () {
        tags = fetchedTags;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTitle(
        title: 'Tags',
        showSearchBar: false,
        showBottomDivider: true,
      ),
      body: GridView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return TagContainer(tag: tags[index]);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
      ),
    );
  }
}
