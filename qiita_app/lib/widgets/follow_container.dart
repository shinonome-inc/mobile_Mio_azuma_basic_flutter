import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/constants/app_text_style.dart';

class FollowContainer extends StatelessWidget {
  const FollowContainer({
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
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://picsum.photos/seed/picsum/400/300"),
                    radius: 16,
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Qiita キータ',
                        style: AppTextStyles.h3BasicBlack,
                        ),
                        Text(
                          '@Qiita',
                          style: AppTextStyles.h3BasicSecondary,
                          ),
                    ],
                  ),
                 
                ],
                
              ),
              SizedBox(height: 4),
               Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Posts:9',
                        style: AppTextStyles.h3BasicBlack,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'フォローしているアカウント詳細フォローしているアカウント詳細フォローしているアカウント詳細',
                        style: AppTextStyles.h3BasicSecondary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        ),
                        
                    ],
                  ),
            ],
          ),
          ),
      
      ),

    );
  }



//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 backgroundImage:
//                     NetworkImage("https://picsum.photos/seed/picsum/400/300"),
//                 radius: 19,
//               ),
//               SizedBox(width: 8),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Qiita',
//                     style: AppTextStyles.h3BasicBlack,
//                   ),
//                   SizedBox(width: 4),
//                   Text(
//                     '@Qiita',
//                     style: AppTextStyles.h3BasicSecondary,
//                   )
//                 ],
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Posts:9',
//                       style: AppTextStyles.h3BasicBlack,
//                     ),
//                     Text(
//                       'followの紹介文が入ります。followの紹介文が入ります。',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
}