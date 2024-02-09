import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
}
