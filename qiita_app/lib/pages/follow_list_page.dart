import 'package:flutter/material.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/follow_container.dart';

class FollowListPage extends StatefulWidget {
  const FollowListPage({super.key});

  @override
  State<FollowListPage> createState() => _FollowListPageState();
}

class _FollowListPageState extends State<FollowListPage> {
  // List<Article> articles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTitle(
        title: 'Follow',
        showBottomDivider: true,
        showReturnIcon: true,
      ),
      body: Builder(builder: (context) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const FollowContainer();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
