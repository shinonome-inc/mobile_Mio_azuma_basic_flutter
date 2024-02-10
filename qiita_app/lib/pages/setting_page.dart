import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.withOpacity(0.5),
            height: 1,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontFamily: 'Pacifico'),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 32.0, bottom: 8.0, left: 16.0),
            child: Text(
              'アプリ情報',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text(
              'プライバシーポリシー',
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // プライバシーポリシー画面に移動する処理をあとで追加
            },
          ),
          const Divider(
            color: AppColors.divider,
            height: 1.0,
            indent: 16,
          ),
          ListTile(
            tileColor: Colors.white,
            title: const Text('利用規約'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 利用規約画面に移動する処理をあとで追加
            },
          ),
          const Divider(
            color: AppColors.divider,
            height: 1.0,
            indent: 16,
          ),
          const ListTile(
            tileColor: Colors.white,
            title: Row(
              children: [
                Text('アプリバージョン'),
                Spacer(),
                Text('v1.0.0'),
              ],
            ),
          ),
          const Divider(
            color: AppColors.divider,
            height: 1.0,
            indent: 16,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32.0, bottom: 8.0, left: 16.0),
            child: Text(
              'その他',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const ListTile(
            tileColor: Colors.white,
            title: Text('ログアウトする'),
          ),
          const Divider(
            color: AppColors.divider,
            height: 1.0,
            indent: 16,
          ),
        ],
      ),
    );
  }
}
