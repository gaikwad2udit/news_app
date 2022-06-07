import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:news_app/hive/article.dart';

import 'package:news_app/model/news.dart';
import 'package:news_app/provider/bookmark_manager.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/widgets/single_news_card.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NewsListScreen extends StatefulWidget {
  NewsListScreen({
    Key? key,
    required this.newslist,
  }) : super(key: key);

  final News newslist;

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late News _news;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _news = widget.newslist;
    Provider.of<BookmarKManager>(context, listen: false)
        .initialize(widget.newslist);
  }

  void updatelist(int index) async {
    await Provider.of<BookmarKManager>(context, listen: false)
        .storeToLocalandFirebase(index);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Headlines'),
      ),
      body: ListView.builder(
        itemCount: _news.articles.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(
                      title: _news.articles[index].title,
                      sourceName: _news.articles[index].source.name,
                      Description: _news.articles[index].description ?? '',
                      Imageurl: _news.articles[index].urlToImage ?? '',
                      content: _news.articles[index].content ?? '',
                    ),
                  ));
            },
            child: SingleNewsCard(
              title: _news.articles[index].title,
              Description: _news.articles[index].description ?? '',
              Imageurl: _news.articles[index].urlToImage ?? '',
              isbookmarked: _news.articles[index].isbookmarked,
              Onbookmarkedpressed: () => updatelist(index),
            ),
          );
        },
      ),
    );
  }
}
