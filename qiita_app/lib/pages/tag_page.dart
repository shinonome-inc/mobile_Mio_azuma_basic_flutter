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
  late ScrollController _scrollController;
  List<Tag> tags = [];
  bool networkError = false;
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchTags();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> fetchTags() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final List<Tag> fetchTags = await QiitaRepository.fetchQiitaTags(
          page: currentPage); // ページ番号を指定してタグを取得
      setState(() {
        if (currentPage == 1) {
          tags = fetchTags;
        } else {
          tags.addAll(fetchTags);
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        networkError = true;
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      setState(() {
        currentPage++;
        fetchTags();
      });
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage = 1;
            tags.clear();
            fetchTags();
          });
        },
        child: Builder(
          builder: (context) {
            if (isLoading && tags.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (networkError) {
              return NetworkError(
                onPressReload: () {
                  setState(() {
                    networkError = false;
                    fetchTags();
                  });
                },
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                controller: _scrollController,
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  return TagContainer(tag: tags[index]);
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
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
