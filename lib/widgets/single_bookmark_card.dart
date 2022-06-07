import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SingleBookmarkCard extends StatefulWidget {
  final String Imageurl;
  final String title;
  final String Description;
  // final VoidCallback deletepressed;
  final bool isbookmarked;
  final String id;
  const SingleBookmarkCard({
    Key? key,
    required this.Imageurl,
    required this.title,
    required this.Description,
    //required this.deletepressed,
    required this.isbookmarked,
    required this.id,
  }) : super(key: key);

  @override
  State<SingleBookmarkCard> createState() => _SingleBookmarkCardState();
}

class _SingleBookmarkCardState extends State<SingleBookmarkCard> {
  void deletebookmarked() async {
    await Hive.box('bookmarks').delete(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            borderRadius: BorderRadius.all(Radius.circular(40))),
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.height * .8,
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .45,
                      // width: MediaQuery.of(context).size.height * .4,
                      imageUrl: widget.Imageurl,
                      placeholder: (context, url) {
                        return Image.asset('assets/loading.gif');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () {
                                deletebookmarked();
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.pink,
                                size: 35,
                              ))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .32),
                child: AutoSizeText(widget.title,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, top: 8),
                    child: AutoSizeText(
                      widget.Description,
                      style: TextStyle(fontSize: 20),
                      maxLines: 4,
                    )),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
