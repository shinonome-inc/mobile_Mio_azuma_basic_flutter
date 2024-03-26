import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/tags.dart';

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

  static Future<List<Article>> fetchQiitaItems({String query = ''}) async {
    Uri url; // Uriオブジェクトの初期宣言
    if (query.isNotEmpty) {
      // 検索クエリが空でない場合、クエリパラメータを含むURLを構築（エンコードなし）
      url = Uri.parse('${Urls.qiitaBaseUrl}/items?query=$query');
      // // 検索クエリが空でない場合、クエリパラメータを含むURLを構築（エンコードあり）
      // url = Uri.parse(
      //     '${Urls.qiitaBaseUrl}/items?query=${Uri.encodeComponent(query)}');
    } else {
      // 検索クエリが空の場合、クエリパラメータを含まないURLを構築
      url = Uri.parse('${Urls.qiitaBaseUrl}/items');
    }

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

  static buildQuery(String input) {
    // 簡単な前処理: トリミングして、空白で単語に分割
    var words = input.trim().split(RegExp(r"\s+"));

    // クエリ部品を格納するリスト
    List<String> queryParts = [];

    // タグ、キーワードなど特定の条件に応じてクエリ部品を組み立てる
    for (var word in words) {
      if (word.startsWith("#")) {
        // タグ指定の場合 (例: "#Flutter")
        queryParts.add("tag:${word.substring(1)}");
      } else if (word.startsWith("@")) {
        // ユーザー指定の場合 (例: "@user")
        queryParts.add("user:${word.substring(1)}");
      } else {
        // 一般的なキーワードの場合
        // タイトル、本文、コード内にキーワードが含まれている記事を検索
        queryParts.add("title:$word OR body:$word OR code:$word");
      }
    }

    // クエリ部品を結合して完全なクエリを生成
    return queryParts.join(" ");
  }

  static Future<List<Tag>> fetchQiitaTags() async {
    final url =
        Uri.parse('${Urls.qiitaBaseUrl}/tags?page=1&per_page=20&sort=count');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      final List<Tag> tagList =
          jsonResponse.map((data) => Tag.fromJson(data)).toList();
      return tagList;
    } else {
      debugPrint(
          'Failed to fetch Qiita tags. Status code: ${response.statusCode}');
      return [];
    }
  }

  static Future<List<Article>> fetchArticlesByTag(
      String tagId, int page) async {
    final url = Uri.parse(
        '${Urls.qiitaBaseUrl}/tags/$tagId/items?page=$page&per_page=20');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => Article.fromJson(data)).toList();
      } else {
        throw Exception(_exceptionMessage(response.statusCode));
      }
    } catch (e) {
      throw Exception('Failed to load articles for tag  $e');
    }
  }
}
