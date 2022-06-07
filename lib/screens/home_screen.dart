import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/hive/article.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/news_list_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/widgets/single_bookmark_card.dart';
import 'package:news_app/widgets/single_news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late News _news;

  Future<News> getNewsJson() async {
    try {
      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=66f6da369a3a434bb1cebed03b66b356'));

      //  log(response.body);
      var result = json.decode(response.body);

      _news = News.fromJson(result);

      return _news;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      onTap: () async {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.red),
                          Text('  Logout'),
                        ],
                      )),
                ];
              },
            )
          ],
          title: Text('home screen'),
          bottom: TabBar(
              //controller: ,
              tabs: [
                Tab(child: Text('News')),
                Tab(child: Text('Bookmarks')),
              ]),
        ),
        body: TabBarView(children: [
          Container(
            child: Center(
              child: ElevatedButton(
                  onPressed: () async {
                    var res = await getNewsJson();

                    //print(res.articles[0].urlToImage);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsListScreen(
                            newslist: res,
                          ),
                        ));
                  },
                  child: Text("Get News")),
            ),
          ),
          Container(
            child: ValueListenableBuilder(
              valueListenable: Hive.box('bookmarks').listenable(),
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: Hive.box('bookmarks').length,
                  itemBuilder: (context, index) {
                    var news = Hive.box('bookmarks').getAt(index) as Article;
                    //print(news.id);
                    return SingleBookmarkCard(
                      Imageurl: news.urlToImage,
                      title: news.title,
                      Description: news.description,
                      isbookmarked: news.isbookmarked,
                      id: news.id,
                    );
                    ;
                  },
                );
              },
            ),
          )
        ]),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Hive.deleteFromDisk();
        //   },
        // ),
      ),
    );
  }
}
