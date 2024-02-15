import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qiita_app/models/article.dart';
import '../constants/urls.dart';

class QiitaRepository {
  static Future<List<Article>> fetchQiitaItems() async {
    final url = Uri.parse('${Urls.qiitaBaseUrl}/items');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => Article.fromJson(data)).toList();
      } else {
        // ステータスコードに応じたエラーメッセージを設定
        switch (response.statusCode) {
          case 400:
            throw Exception(
                'Bad request. Please check the request format and try again.');
          case 401:
            throw Exception(
                'Unauthorized. You might not have permission to access the data.');
          case 403:
            throw Exception(
                'Forbidden. Access to the requested resource is denied.');
          case 404:
            throw Exception(
                'Not found. The requested resource could not be found.');
          case 500:
            throw Exception('Internal Server Error. Please try again later.');
          default:
            throw Exception(
                'Failed to fetch Qiita items. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // 例外が発生した場合のエラーハンドリング
      debugPrint('Exception caught: $e');
      throw Exception('Failed to load Qiita items: $e');
    }
  }
}
