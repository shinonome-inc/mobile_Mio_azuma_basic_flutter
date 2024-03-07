import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/widgets/app_title.dart';
import 'package:qiita_app/widgets/setting_section_title.dart';

import '../widgets/setting_item.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String version = 'v0.0.0';
  Future<void> setVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = 'v${packageInfo.version}';
    });
  }

  @override
  void initState() {
    super.initState();
    setVersion();
  }

  Widget buildCustomDivider({
    Color color = AppColors.divider,
    double height = 0.5,
    double indent = 16.0,
  }) {
    return Divider(
      color: color,
      height: height,
      indent: indent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTitle(
        title: "Settings",
        showSearchBar: false,
        showBottomDivider: true,
      ),
      body: ListView(
        children: [
          const SectionTitle(title: 'アプリ情報'),
          SettingItem(
            title: 'プライバシーポリシー',
            onTap: () {
              // プライバシーポリシー画面に移動する処理をあとで追加
            },
          ),
          buildCustomDivider(),
          SettingItem(
            title: '利用規約',
            onTap: () {
              // 利用規約画面に移動する処理をあとで追加
            },
          ),
          buildCustomDivider(),
          ListTile(
            tileColor: Colors.white,
            title: Row(
              children: [
                const Text('アプリバージョン'),
                const Spacer(),
                Text(version),
              ],
            ),
          ),
          buildCustomDivider(),
          const SectionTitle(title: 'その他'),
          SettingItem(
            title: 'ログアウトする',
            onTap: () {
              // ログアウト処理をあとで追加
            },
            showArrow: false,
          ),
          buildCustomDivider(),
        ],
      ),
    );
  }
}
