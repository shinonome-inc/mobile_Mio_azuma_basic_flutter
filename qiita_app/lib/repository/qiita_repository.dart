import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_app/models/article.dart';
import 'package:qiita_app/models/tags.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<List<Article>> fetchQiitaItems(
      {int page = 1, String query = ''}) async {
    Uri url; // Uriオブジェクトの初期宣言
    if (query.isNotEmpty) {
      // 検索クエリが空でない場合、クエリパラメータを含むURLを構築（エンコードなし）
      url = Uri.parse('${Urls.qiitaBaseUrl}/items?query=$query');
      // // 検索クエリが空でない場合、クエリパラメータを含むURLを構築（エンコードあり）
      // url = Uri.parse(
      //     '${Urls.qiitaBaseUrl}/items?query=${Uri.encodeComponent(query)}');
    } else {
      // 検索クエリが空の場合、クエリパラメータを含まないURLを構築
      url = Uri.parse('${Urls.qiitaBaseUrl}/items?page=$page');
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

  static Future<void> requestAccessToken(String code) async {
    final String? clientId = dotenv.env['CLIENT_ID'];
    final String? clientSecret = dotenv.env['CLIENT_SECRET'];
    const String accessTokenUrl = '${Urls.qiitaBaseUrl}/access_tokens';

    if (clientId == null || clientSecret == null) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(accessTokenUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
        }),
      );

      if (response.statusCode == 201) {
        // リクエストが成功した場合、レスポンスからアクセストークンを取得
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final String accessToken = jsonResponse['token'].toString();

        // SharedPreferencesを使用してアクセストークンを保存
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        if (kDebugMode) {
          print(accessToken);
        }
      } else {
        // リクエストが失敗した場合のエラーハンドリング
        final errorMessage =
            'Failed to request access token: ${response.statusCode}';
        throw Exception(errorMessage);
      }
    } catch (e) {
      // 例外が発生した場合のエラーハンドリング
      final errorMessage = 'Failed to request access token: $e';
      throw Exception(errorMessage);
    }
  }
}
