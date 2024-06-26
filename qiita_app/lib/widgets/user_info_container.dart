import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/models/user.dart';
import 'package:qiita_app/pages/follower_following_list_page.dart';

class UserInfoContainer extends StatefulWidget {
  final User user;

  const UserInfoContainer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserInfoContainer> createState() => _UserInfoContainerState();
}

class _UserInfoContainerState extends State<UserInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 12, right: 24, left: 24, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.profileImageUrl),
                radius: 40,
              ),
              const SizedBox(height: 8),
              Text(
                widget.user.name,
                style: AppTextStyles.h2BasicBlack,
              ),
              Text(
                '@${widget.user.id}',
                style: AppTextStyles.h3BasicSecondary,
              ),
              const SizedBox(height: 12),
              if (widget.user.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  widget.user.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],
              Row(
                children: [
                  InkWell(
                    onTap: widget.user.followeesCount > 0
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FollowerFollowingListPage(
                                  listType: 'following',
                                  userId: widget.user.id, // ユーザーIDを渡す
                                ),
                              ),
                            );
                          }
                        : null,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.user.followeesCount} ',
                            style: AppTextStyles.h3BasicBlack,
                          ),
                          const TextSpan(
                            text: 'フォロー中',
                            style: AppTextStyles.h3BasicSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: widget.user.followersCount > 0
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FollowerFollowingListPage(
                                  listType: 'followers',
                                  userId: widget.user.id, // ユーザーIDを渡す
                                ),
                              ),
                            );
                          }
                        : null,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.user.followersCount} ',
                            style: AppTextStyles.h3BasicBlack,
                          ),
                          const TextSpan(
                            text: 'フォロワー',
                            style: AppTextStyles.h3BasicSecondary,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
