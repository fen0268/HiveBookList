import 'package:hive/hive.dart';
import 'package:hive_book_list_sample/utils/hive_box_name_constants.dart';
import 'package:uuid/uuid.dart';

import '../domain/book.dart';

class BooksBox {
  final box = Hive.openBox<Book>(HiveBoxNameConstants.books);
}

class BooksRepository {
  BooksRepository(BooksBox booksBox) {
    _booksBox = booksBox;
  }

  late BooksBox _booksBox;

  Future<List<Book>> fetchAll() async {
    try {
      final box = await _booksBox.box;
      return box.isEmpty ? [] : box.values.toList();
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> add({required String title, required String author}) async {
    try {
      final box = await _booksBox.box;
      await box.add(Book(id: const Uuid().v4(), title: title, author: author));
    } catch (e) {
      throw Exception();
    }
  }
}
