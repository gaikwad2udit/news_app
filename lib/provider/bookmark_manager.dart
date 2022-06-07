import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:news_app/hive/article.dart';
import 'package:news_app/model/news.dart';

class BookmarKManager with ChangeNotifier {
  late News news;

  void initialize(News newslist) {
    news = newslist;
  }

  Future<void> storeToLocalandFirebase(int index) async {
    var temp = news.articles[index];
    var article = Article(
        id: temp.Id!,
        title: temp.title,
        content: temp.content,
        description: temp.description!,
        urlToImage: temp.urlToImage!,
        isbookmarked: temp.isbookmarked);
    print(temp.Id);
    print(article.id);

    if (news.articles[index].isbookmarked) {
      print('deleting');

      await Hive.box('bookmarks').delete(article.id);

      var res = await FirebaseFirestore.instance
          .collection('bookmarks')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('bookmark')
          .where('id', isEqualTo: article.id)
          .get();
      await res.docs.first.reference.delete();
    } else {
      print('adding');
      await Hive.box('bookmarks').put(article.id, article);

      await FirebaseFirestore.instance
          .collection('bookmarks')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('bookmark')
          .doc()
          .set({
        'id': article.id,
        'title': article.title,
        'description': article.description,
        'imageurl': article.urlToImage,
        'content': article.content
      });
    }
    news.articles[index].isbookmarked = !news.articles[index].isbookmarked;
  }
}
