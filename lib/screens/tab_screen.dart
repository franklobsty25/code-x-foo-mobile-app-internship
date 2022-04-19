import 'package:flutter/material.dart';
import 'package:ign/screens/article_screen.dart';
import 'package:ign/screens/video_screen.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  minRadius: 15.0,
                  backgroundImage: AssetImage(
                    'images/ign1.png',
                  ),
                ),
                Image.asset(
                  'images/ign.png',
                  width: 50.0,
                  height: 200.0,
                ),
              ],
            ),
          ),
          bottom: const TabBar(
            indicatorWeight: 4.0,
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.article), text: 'ARTICLES'),
              Tab(icon: Icon(Icons.play_arrow), text: 'VIDEOS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ArticleScreen(),
            VideoScreen(),
          ],
        ),
      ),
    );
  }
}
