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
  State<FollowFollowingListPage> createState() => _FollowFollowingListPageState();
}


class _FollowFollowingListPageState extends State<FollowFollowingListPage> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      User authenticatedUser = await QiitaRepository.fetchAuthenticatedUserInfo();
      List<User> fetchedUsers;
      if (widget.listType == 'following') {
        fetchedUsers = await QiitaRepository.fetchFollowingUsers(authenticatedUser.id);
      } else {
        fetchedUsers = await QiitaRepository.fetchFollowersUsers(authenticatedUser.id);
      }
      debugPrint('${fetchedUsers.length} users loaded successfully');

      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching users: $e');
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