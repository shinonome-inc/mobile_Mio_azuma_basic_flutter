class Tag {
  final String? iconUrl;
  final String id;
  final int itemsCount;
  final int followersCount;

  Tag({
    required this.iconUrl,
    required this.id,
    required this.itemsCount,
    required this.followersCount,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      iconUrl: json['icon_url'],
      id: json['id'] as String,
      itemsCount: json['items_count'] as int,
      followersCount: json['followers_count'] as int,
    );
  }
}
