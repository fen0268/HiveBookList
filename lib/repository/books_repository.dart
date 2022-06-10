import 'dart:typed_data';

import 'package:hive/hive.dart';

import '../domain/book.dart';
import '../utils/hive_box_name_constants.dart';

class BooksBox {
  final box = Hive.openBox<Book>(HiveBoxNameConstants.books);
}

class BooksRepository {
  BooksRepository(BooksBox booksBox) {
    _booksBox = booksBox;
  }

  late BooksBox _booksBox;

  Future<List<Book>> fetchAll() async {
    final box = await _booksBox.box;
    return box.isEmpty ? [] : box.values.toList();
  }

  Future<void> add({
    required String title,
    required String author,
    required Uint8List? uInt,
  }) async {
    final box = await _booksBox.box;
    await box.add(
      Book(title: title, author: author, uInt: uInt),
    );
  }
}
