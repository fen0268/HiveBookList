import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book extends HiveObject {
  Book({
    required this.title,
    required this.author,
    required this.uInt,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String author;

  @HiveField(2)
  Uint8List? uInt;
}
