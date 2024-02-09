class Article {
  final int id;
  final String name;
  final List<String> types;
  // final String imageUrl;

  Article({
    required this.id,
    required this.name,
    required this.types,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    List<String> typesToList(dynamic types) {
      List<String> ret = [];
      for (int i = 0; i < types.length; i++) {
        ret.add(types[i]['type']['name']);
      }
      return ret;
    }

    return Article(
      id: json['id'],
      name: json['name'],
      types: typesToList(json['types']),
    );
  }
}
