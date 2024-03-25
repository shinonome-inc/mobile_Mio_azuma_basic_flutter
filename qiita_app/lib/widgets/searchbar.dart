import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

class SearchBarWithIcon extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  const SearchBarWithIcon({
    Key? key,
    required this.searchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchBarWithIcon> createState() => _SearchBarWithIconState();
}

class _SearchBarWithIconState extends State<SearchBarWithIcon> {
  bool _isTextPresent = false;

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_updateTextPresence); // リスナーを追加
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_updateTextPresence); // リスナーを削除
    super.dispose();
  }

  // テキストフィールドのテキストの有無に基づいてステートを更新
  void _updateTextPresence() {
    final isTextPresent = widget.searchController.text.isNotEmpty;
    if (isTextPresent != _isTextPresent) {
      setState(
        () {
          _isTextPresent = isTextPresent;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(
            fontSize: 17,
          ),
          fillColor: AppColors.gray,
          filled: true,
          prefixIcon: const Padding(
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.search,
              color: AppColors.secondary,
              size: 20,
            ),
          ),
          suffixIcon: _isTextPresent
              ? IconButton(
                  onPressed: () {
                    widget.searchController.clear(); // テキストフィールドをクリア
                    widget.onSearch(''); // 最新の記事を表示させるために空のクエリで検索関数を呼び出す
                    _updateTextPresence(); // 状態を更新
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        controller: widget.searchController,
        onSubmitted: widget.onSearch, // 親ウィジェットから渡された検索関数を実行
      ),
    );
  }
}
