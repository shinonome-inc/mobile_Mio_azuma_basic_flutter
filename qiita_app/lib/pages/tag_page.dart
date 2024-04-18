import 'package:flutter/material.dart';
import 'package:qiita_app/models/tags.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/network_error.dart';
import 'package:qiita_app/widgets/tag_container.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  late Future<List<Tag>> _tagsFuture;
  bool networkError = false;

  @override
  void initState() {
    super.initState();
    _tagsFuture = fetchTags();
  }

  Future<List<Tag>> fetchTags() async {
    try {
      return await QiitaRepository.fetchQiitaTags();
    } catch (e) {
      // ネットワークエラーが発生した場合は、空のリストを返す
      setState(() {
        networkError = true;
      });
      return [];
    }
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
      body: FutureBuilder<List<Tag>>(
        future: _tagsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (networkError ||
              snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return NetworkError(
              onPressReload: () {
                setState(() {
                  networkError = false;
                  _tagsFuture = fetchTags();
                });
              },
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return TagContainer(tag: snapshot.data![index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
