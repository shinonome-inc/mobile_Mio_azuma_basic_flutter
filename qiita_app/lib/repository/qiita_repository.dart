import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/urls.dart';

class QiitaRepository {
  static Future<void> fetchQiitaItems() async {
    final url = Uri.parse('${Urls.qiitaBaseUrl}/item');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      debugPrint('Response body: ${response.body}');
    } else {
      debugPrint(
          'Failed to fetch Qiita items. Status code: ${response.statusCode}');
    }
  }

  static Future<void> fetchQiitaTags() async {
    final url =
        Uri.parse('${Urls.qiitaBaseUrl}/tags?page=1&per_page=20&sort=count');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      debugPrint('Response body: ${response.body}');
    } else {
      debugPrint(
          'Failed to fetch Qiita tags. Status code: ${response.statusCode}');
    }
  }
}
