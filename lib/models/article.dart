class Article {
  final String? contentId;
  final List? imageUrl;
  final String? headline;
  final String? description;
  final String? publishDate;
  final List? authorName;
  final List? authorImageUrl;

  Article({
    this.contentId,
    this.imageUrl,
    this.headline,
    this.description,
    this.authorName,
    this.authorImageUrl,
    this.publishDate,
  });

  static Article fromJson(Map<String, dynamic> json) {
    return Article(
      contentId: json["contentId"],
      imageUrl: json["thumbnails"],
      headline: json["metadata"]["headline"],
      description: json["metadata"]["description"],
      publishDate: json["metadata"]["publishDate"],
      authorName: json["authors"],
      authorImageUrl: json["authors"],
    );
  }
}
