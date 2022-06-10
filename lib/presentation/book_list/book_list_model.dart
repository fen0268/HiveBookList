import 'package:flutter/material.dart';

import '../../domain/book.dart';
import '../../repository/books_repository.dart';

class BookListModel extends ChangeNotifier {
  BookListModel(BooksRepository booksRepository) {
    _booksRepository = booksRepository;
  }
  late BooksRepository _booksRepository;
  List<Book> books = [];

  void fetchBookList() async {
    books = await _booksRepository.fetchAll();
    notifyListeners();
  }

  Future<void> delete(Book book) async {
    book.delete();
    notifyListeners();
  }
}
