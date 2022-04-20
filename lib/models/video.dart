class Video {
  final String? contentId;
  final List? videoUrl;
  final String? title;
  final String? description;
  final String? publishDate;
  final List? assets;

  Video({
    this.contentId,
    this.videoUrl,
    this.title,
    this.description,
    this.publishDate,
    this.assets,
  });

  static Video fromJson(Map<String, dynamic> json) {
    return Video(
      contentId: json["contentId"],
      videoUrl: json["thumbnails"],
      title: json["metadata"]["title"],
      description: json["metadata"]["description"],
      publishDate: json["metadata"]["publishDate"],
      assets: json["assets"],
    );
  }
}
