class Space {
  String id;
  final String? copyright;
  final String date;
  final String explanation;
  final String? hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;
  bool isFavorite;

  Space({
    required this.id,
    this.copyright,
    required this.date,
    required this.explanation,
    this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
    bool? isFavorite,
  }) : isFavorite = isFavorite ?? false;

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      id: json['id'] ?? '',
      copyright: json['copyright'],
      date: json['date'] ?? '',
      explanation: json['explanation'] ?? '',
      hdurl: json['hdurl'],
      mediaType: json['media_type'] ?? '',
      serviceVersion: json['service_version'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'copyright': copyright,
      'date': date,
      'explanation': explanation,
      'hdurl': hdurl,
      'media_type': mediaType,
      'service_version': serviceVersion,
      'title': title,
      'url': url,
    };
  }
}