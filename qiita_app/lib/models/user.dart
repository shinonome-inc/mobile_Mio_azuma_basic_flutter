class User {
  final String profileImageUrl;
  final String name;
  final String id;
  final String description;
  final int followeesCount;
  final int followersCount;
  final String url;

  User({
    required this.profileImageUrl,
    required this.name,
    required this.id,
    required this.description,
    required this.followeesCount,
    required this.followersCount,
    required this.url,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profileImageUrl: json['profile_image_url'] as String,
      name: json['name'] as String? ?? '', // nullの場合、デフォルト値として空文字列を設定
      id: json['id'] as String,
      description:
          json['description'] as String? ?? '', // nullの場合、デフォルト値として空文字列を設定
      followeesCount: json['followees_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      url: json['url'] as String? ?? '',
    );
  }
}
