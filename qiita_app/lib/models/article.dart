import 'package:intl/intl.dart';

class Article {
  final String title;
  final String userIconUrl;
  final String userName;
  final String postedDate;
  final int likesCount;

  Article({
    required this.title,
    required this.userIconUrl,
    required this.userName,
    required this.postedDate,
    required this.likesCount,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    final DateTime dateTime = DateTime.parse(json['created_at']);
    final String formattedDate = formatter.format(dateTime);

    return Article(
      title: json['title'] as String,
      userIconUrl: json['user']['profile_image_url'],
      userName: json['user']['id'] as String,
      postedDate: formattedDate,
      likesCount: json['likes_count'] ?? 0,
    );
  }
}
