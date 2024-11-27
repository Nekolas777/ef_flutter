class FavoriteSpace {
  final String id;
  final String title;
  final String explanation;
  final String url;

  FavoriteSpace({
    required this.id,
    required this.title,
    required this.explanation,
    required this.url,
  });

  factory FavoriteSpace.fromJson(Map<String, dynamic> json) {
    return FavoriteSpace(
      id: json['id'],
      title: json['title'],
      explanation: json['explanation'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'explanation': explanation,
      'url': url,
    };
  }
}