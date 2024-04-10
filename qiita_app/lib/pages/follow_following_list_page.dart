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

// class _FollowFollowingListPageState extends State<FollowFollowingListPage> {
//   List<User> users = []; // ユーザーのリストを保持するための変数
//   bool isLoading = true;

//     @override
//   void initState() {
//     super.initState();
//     if (widget.listType == 'following') {
//       fetchFollowing();
//     } else if (widget.listType == 'followers') {
//       fetchFollowers();
//     }
//   }
//      void fetchFollowing() async {
//     try {
//       // 認証済みユーザー情報の取得
//       User authenticatedUser = await QiitaRepository.fetchAuthenticatedUserInfo();
//       debugPrint('Authenticated user loaded successfully: ${authenticatedUser.name}');

//       // フォローしているユーザーのリストを取得
//       List<User> fetchedFollowing = await QiitaRepository.fetchFollowingUsers(authenticatedUser.id);
//       debugPrint('${fetchedFollowing.length} users loaded successfully');

//       setState(() {
//         users = fetchedFollowing; // UIを更新
//       });
//     } catch (e) {
//       debugPrint('Error fetching followee list: $e');
//       // ここでエラーメッセージを表示するなどのエラーハンドリングを行う
//     }
//   }

//   void fetchFollowers() async {
//     try {
//       // 認証済みユーザー情報の取得
//       User authenticatedUser = await QiitaRepository.fetchAuthenticatedUserInfo();
//       debugPrint('Authenticated user loaded successfully: ${authenticatedUser.name}');

//       // フォローしているユーザーのリストを取得
//       List<User> fetchedFollowee = await QiitaRepository.fetchFollowersUsers(authenticatedUser.id);
//       debugPrint('${fetchedFollowee.length} users loaded successfully');

//       setState(() {
//         users = fetchedFollowee; // UIを更新
//       });
//     } catch (e) {
//       debugPrint('Error fetching followee list: $e');
//       // ここでエラーメッセージを表示するなどのエラーハンドリングを行う
//     }
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const AppTitle(
//         title: 'Follow',
//         showBottomDivider: true,
//         showReturnIcon: true,
//       ),
//       body: Builder(builder: (context) {
//         return Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: users.length, 
//                 itemBuilder: (context, index) {
//                   return  FollowContainer(
//                     user: users[index],
//                     );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }