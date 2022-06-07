import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleNewsCard extends StatelessWidget {
  final String Imageurl;
  final String title;
  final String Description;

  final bool isbookmarked;
  final VoidCallback Onbookmarkedpressed;

  const SingleNewsCard({
    Key? key,
    required this.Imageurl,
    required this.title,
    required this.Description,
    required this.isbookmarked,
    required this.Onbookmarkedpressed,
  }) : super(key: key);

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
                      imageUrl: Imageurl,
                      placeholder: (context, url) {
                        return Image.asset('assets/loading.gif');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: Onbookmarkedpressed,
                              child: Icon(
                                Icons.star,
                                size: 35,
                                color: isbookmarked
                                    ? Colors.pink
                                    : Color.fromARGB(137, 44, 44, 44),
                              ))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .32),
                child: AutoSizeText(title,
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
                      Description,
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
