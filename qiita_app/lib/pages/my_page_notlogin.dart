import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_text_style.dart';
import 'package:qiita_app/pages/top_page.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/rounded_edge_button.dart';

class MyPageNotLogin extends StatefulWidget {
  const MyPageNotLogin({Key? key}) : super(key: key);

  @override
  State<MyPageNotLogin> createState() => _MyPageNotLoginState();
}

class _MyPageNotLoginState extends State<MyPageNotLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTitle(
        title: 'MyPage',
        showBottomDivider: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'ログインが必要です',
              style: AppTextStyles.h2BasicBlack,
            ),
            const SizedBox(height: 6),
            const Text(
              'マイページの機能を利用するには',
              style: AppTextStyles.h3BasicSecondary,
            ),
            const Text(
              'ログインを行っていただく必要があります。',
              style: AppTextStyles.h3BasicSecondary,
            ),
            const Spacer(),
            RoundedEdgeButton(
              text: 'ログインする',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TopPage(title: 'toppage',),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
