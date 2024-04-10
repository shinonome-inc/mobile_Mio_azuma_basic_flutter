import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/models/user.dart';

class FollowContainer extends StatelessWidget {
  final User user;

  const FollowContainer({
    required this.user,
    
    Key? key,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ユーザー画面へ
      // onTap: (() {
      //   Navigator.push(
      //     context, 
      //     MaterialPageRoute(
      //       builder: ((context) => userPage(),))

      //     ),
      // }
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Column(
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.profileImageUrl),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: AppTextStyles.h3BasicBlack,
                      ),
                      Text(
                        user.id,
                        style: AppTextStyles.h3BasicSecondary,
                        ),
                  ],
                ),
               
              ],
              
            ),
            const SizedBox(height: 4),
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Posts:${user.itemsCount}',
                      style: AppTextStyles.h3BasicBlack,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.description,
                      style: AppTextStyles.h3BasicSecondary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      ),
                      
                  ],
                ),
          ],
        ),
        ),

    );
  }
}