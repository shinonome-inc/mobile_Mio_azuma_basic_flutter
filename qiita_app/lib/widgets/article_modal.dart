import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/widgets/app_bottom_modal_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleModal extends StatefulWidget {
  const ArticleModal({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  State<ArticleModal> createState() => _ArticleModalState();
}

class _ArticleModalState extends State<ArticleModal> {
  late WebViewController controller = WebViewController()
    ..loadRequest(
      Uri.parse(widget.article.url),
    );

  @override
  Widget build(BuildContext context) {
    return AppBottomModalSheet(
      title: 'Article',
      content: WebViewWidget(controller: controller),
    );
  }
}
