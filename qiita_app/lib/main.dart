import 'package:flutter/material.dart';
import 'package:qiita_app/constants/app_colors.dart';

import 'pages/top_page.dart';
import 'repository/qiita_repository.dart';

void main() {
  runApp(const MyApp());
  QiitaRepository.fetchQiitaItems(PaginatedDataTable.defaultRowsPerPage);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qiita_app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: AppColors.background,
        ),
        dividerColor: AppColors.divider,
      ),
      home: const TopPage(title: 'Qiita Feed App'),
    );
  }
}
