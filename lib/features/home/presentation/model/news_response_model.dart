class NewsResponseModel {
  String? category;
  int? datetime;
  String? headline;
  int? id;
  String? image;
  String? related;
  String? source;
  String? summary;
  String? url;

  NewsResponseModel({
    this.category,
    this.datetime,
    this.headline,
    this.id,
    this.image,
    this.related,
    this.source,
    this.summary,
    this.url,
  });

  // Factory constructor to create a NewsResponseModel from JSON
  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      category: json['category'],
      datetime: json['datetime'],
      headline: json['headline'],
      id: json['id'],
      image: json['image'],
      related: json['related'],
      source: json['source'],
      summary: json['summary'],
      url: json['url'],
    );
  }

  // Static method to convert JSON list to List<NewsResponseModel>
  static List<NewsResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NewsResponseModel.fromJson(json)).toList();
  }
}
