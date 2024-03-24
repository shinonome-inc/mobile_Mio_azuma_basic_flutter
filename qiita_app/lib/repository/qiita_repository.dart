import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_app/models/article.dart';

import '../constants/urls.dart';

class QiitaRepository {
  static String _exceptionMessage(int statusCode) {
    debugPrint('Status code: $statusCode');
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check the request format and try again.';
      case 401:
        return 'Unauthorized. You might not have permission to access the data.';
      case 403:
        return 'Forbidden. Access to the requested resource is denied.';
      case 404:
        return 'Not found. The requested resource could not be found.';
      case 500:
        return 'Internal Server Error. Please try again later.';
      default:
        return 'Failed to make request.';
    }
  }

  static Future<List<Article>> fetchQiitaItems(int page) async {
    final url = Uri.parse('${Urls.qiitaBaseUrl}/items?page=$page');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => Article.fromJson(data)).toList();
      } else {
        // ステータスコードに応じたエラーメッセージを設定
        throw Exception(_exceptionMessage(response.statusCode));
      }
    } catch (e) {
      // 例外が発生した場合のエラーハンドリング
      throw Exception('Failed to load Qiita items: $e');
    }
  }
}
