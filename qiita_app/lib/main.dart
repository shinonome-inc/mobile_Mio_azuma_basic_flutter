import 'package:flutter/material.dart';
import 'pages/top_page.dart';
import 'repository/qiita_repository.dart';

void main() {
  runApp(const MyApp());
  QiitaRepository.fetchQiitaItems();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qiita_app',
      theme: ThemeData(),
      home: const TopPage(title: 'Qiita Feed App'),
    );
  }
}
