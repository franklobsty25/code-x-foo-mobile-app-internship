import 'package:flutter/material.dart';
import 'package:ign/providers/article_provider.dart';
import 'package:ign/providers/video_provider.dart';
import 'package:ign/screens/tab_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ArticleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VideoProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'IGN',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const TabScreen(),
      ),
    );
  }
}
