import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewsDetailScreen extends StatelessWidget {
  final String Imageurl;
  final String title;
  final String Description;
  final String sourceName;
  final String content;

  NewsDetailScreen({
    Key? key,
    required this.Imageurl,
    required this.title,
    required this.Description,
    required this.sourceName,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                child: CachedNetworkImage(
                    imageUrl: Imageurl,
                    placeholder: (context, url) =>
                        Image.asset('assets/loading.gif'))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  Description,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Text(content)
          ],
        ),
      ),
    );
  }
}
