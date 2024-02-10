import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import '../constants/urls.dart';

class QiitaRepository {
  static Future<List<Article>> fetchQiitaItems() async {
    final url = Uri.parse('${Urls.qiitaBaseUrl}/items');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Article.fromJson(data)).toList();
      // debugPrint('Response body: ${response.body}');
    } else {
      debugPrint(
          'Failed to fetch Qiita items. Status code: ${response.statusCode}');
      return [];
    }
  }
}
