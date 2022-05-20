import 'package:flutter/material.dart';
import 'package:hive_book_list_sample/repository/books_repository.dart';

import '../../domain/book.dart';

class BookListModel extends ChangeNotifier {
  BookListModel(BooksRepository booksRepository) {
    _booksRepository = booksRepository;
  }
  late BooksRepository _booksRepository;
  List<Book> books = [];

  ///全取得
  Future<void> fetchBooks() async {
    books = await _booksRepository.fetchAll();
    notifyListeners();
  }

  Future<void> delete({required Book book}) async {
    book.delete();
    notifyListeners();
  }
}
