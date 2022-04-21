import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ign/widgets/author.dart';
import 'package:ign/widgets/footer.dart';
import 'package:ign/widgets/ign_video.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ign/providers/video_provider.dart';
import 'package:ign/providers/article_provider.dart';

class Detail extends StatelessWidget {
  final bool isVideo;
  const Detail({Key? key, this.isVideo = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isVideo
          ? Provider.of<VideoProvider>(context, listen: false)
              .getVideosFromUrl()
          : Provider.of<ArticleProvider>(context, listen: false)
              .getArticlesFromUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return isVideo
            ? Consumer<VideoProvider>(
                builder: (context, video, child) {
                  if (video.videos.isEmpty) {
                    return const Center(
                      child: Text('No video found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: video.videos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            await launch(
                                (video.videos[index].assets!.isNotEmpty)
                                    ? video.videos[index].assets![0]['url']
                                    : 'https://www.ign.com');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: (video.videos[index].publishDate != null)
                                    ? Text(
                                        '${DateTime.parse(video.videos[index].publishDate!).minute} MIN AGO',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : Container(),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        video.videos[index].title!,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      if (video
                                          .videos[index].assets!.isNotEmpty)
                                        IgnVideo(
                                          url: video.videos[index].assets![0]
                                              ['url'],
                                        ),
                                      const SizedBox(height: 20.0),
                                      Text((video.videos[index].description !=
                                              null)
                                          ? video.videos[index].description!
                                          : ''),
                                      Footer(
                                        contentId:
                                            video.videos[index].contentId,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : Consumer<ArticleProvider>(
                builder: (context, article, child) {
                  if (article.articles.isEmpty) {
                    return Center(
                      child: Text('No articles found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: article.articles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            await launch((article.articles.isNotEmpty)
                                ? 'https://ign.com?id=${article.articles[index].contentId}'
                                : 'https://ign.com');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: (article.articles[index].publishDate !=
                                        null)
                                    ? Text(
                                        '${DateTime.parse(article.articles[index].publishDate!).minute} MIN AGO',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : Container(),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        article.articles[index].headline!,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Image.network(
                                        (article.articles[index].imageUrl!
                                                .isNotEmpty)
                                            ? article.articles[index]
                                                .imageUrl![0]['url']
                                            : Image.asset('images/ign1.png'),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text((article.articles[index]
                                                  .description ==
                                              null)
                                          ? ''
                                          : article
                                              .articles[index].description!),
                                      Author(
                                          name: (article.articles[index]
                                                  .authorName!.isNotEmpty)
                                              ? article.articles[index]
                                                  .authorName![0]['name']
                                              : '',
                                          thumbnail: (article.articles[index]
                                                  .authorImageUrl!.isNotEmpty)
                                              ? article.articles[index]
                                                      .authorImageUrl![0]
                                                  ['thumbnail']
                                              : ''),
                                      Footer(
                                        contentId:
                                            article.articles[index].contentId,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
      },
    );
  }
}
