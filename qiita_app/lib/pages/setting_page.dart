import 'package:flutter/material.dart';
import 'package:qiita_app/constants/texts.dart';
import 'package:qiita_app/widgets/app_bottom_modal_sheet.dart';
// import 'package:qiita_app/constants/texts.dart';
import 'package:qiita_app/widgets/rounded_edge_button.dart';
import 'package:qiita_app/constants/app_colors.dart';
// import 'package:qiita_app/widgets/app_bottom_modal_sheet.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedEdgeButton(
              text: "プライバシーポリシー",
              backgroundColor: AppColors.primary,
              onPressed: () {
                showAppBottomModalSheet(
                  context,
                  title: "プライバシーポリシー",
                  content: Texts.privacyPolicyText,
                );
              },
            ),
            const SizedBox(
              height: 42,
            ),
            RoundedEdgeButton(
              text: "利用規約",
              backgroundColor: AppColors.primary,
              onPressed: () {
                showAppBottomModalSheet(
                  context,
                  title: "利用規約",
                  content: Texts.termsService,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
