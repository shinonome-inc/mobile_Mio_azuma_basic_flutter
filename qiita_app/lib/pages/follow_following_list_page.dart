import 'package:flutter/material.dart';
import 'package:qiita_app/models/user.dart';
import 'package:qiita_app/repository/qiita_repository.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/follow_container.dart';

class FollowFollowingListPage extends StatefulWidget {
  final String listType;

  const FollowFollowingListPage({
    Key? key,
    required this.listType,
  }) : super(key: key);

  @override
  State<FollowFollowingListPage> createState() =>
      _FollowFollowingListPageState();
}

class _FollowFollowingListPageState extends State<FollowFollowingListPage> {
  List<User> users = [];
  bool isLoading = false;
  int currentPage = 1;
  late ScrollController scrollController;
  // ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    fetchUsers();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

 void _scrollListener() {
  debugPrint('Current scroll position: ${scrollController.position.pixels}');
  if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoading) {
    debugPrint('Reached the bottom of the list.');
    currentPage++; // 次のページ番号を更新
    fetchUsers();
  }
}

  void fetchUsers() async {
  if (isLoading) {
    debugPrint('Currently loading data, request to fetch users cancelled.');
    return;
  }
  debugPrint('Starting to fetch users for page $currentPage.');

  setState(() {
    isLoading = true;
  });

  try {
    User authenticatedUser = await QiitaRepository.fetchAuthenticatedUserInfo();
    debugPrint('Authenticated user info fetched: ${authenticatedUser.id}');

    List<User> fetchedUsers;
    if (widget.listType == 'following') {
      fetchedUsers = await QiitaRepository.fetchFollowingUsers(authenticatedUser.id);
    } else {
      fetchedUsers = await QiitaRepository.fetchFollowersUsers(authenticatedUser.id);
    }
    debugPrint('${fetchedUsers.length} users loaded successfully');

    if (fetchedUsers.isNotEmpty) {
  setState(() {
    users.addAll(fetchedUsers);
    debugPrint('User list updated, total users: ${users.length}');
  });
} else {
  debugPrint('No users fetched');
}

  } catch (e) {
    debugPrint('Error fetching users: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitle(
        title: widget.listType == 'following' ? 'Following' : 'Followers',
        showReturnIcon: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return FollowContainer(user: users[index]);
              },
            ),
    );
  }
}