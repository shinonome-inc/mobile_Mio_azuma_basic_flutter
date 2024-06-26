import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';
import 'package:qiita_app/pages/feed_page.dart';
import 'package:qiita_app/pages/my_page.dart';
import 'package:qiita_app/pages/setting_page.dart';
import 'package:qiita_app/pages/tag_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    TagPage(),
    MyPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'フィード',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tag),
            label: 'タグ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'マイページ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor: AppColors.secondary,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
