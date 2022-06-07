import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String urlToImage;
  @HiveField(4)
  final String? content;
  @HiveField(5)
  bool isbookmarked;
  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.content,
    required this.isbookmarked,
  });
}
