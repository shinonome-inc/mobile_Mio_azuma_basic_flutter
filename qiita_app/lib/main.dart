import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qiita_app/constants/app_colors.dart';

import 'pages/top_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  runApp(const MyApp());
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
