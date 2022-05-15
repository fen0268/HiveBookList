import 'dart:io';

import 'package:hive_flutter/adapters.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book extends HiveObject {
  Book({
    required this.title,
    required this.author,
    required this.image,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String author;

  ///型はFileであってるのか
  @HiveField(2)
  File image;
}
