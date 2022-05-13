import 'package:hive_flutter/adapters.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book extends HiveObject {
  Book({
    required this.id,
    required this.title,
    required this.author,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String author;
}
