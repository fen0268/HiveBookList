import 'package:flutter/material.dart';

import '../../domain/book.dart';
import '../../repository/books_repository.dart';

class BookListModel extends ChangeNotifier {
  BookListModel(BooksRepository booksRepository) {
    _booksRepository = booksRepository;
  }
  late BooksRepository _booksRepository;
  List<Book> books = [];

  Future<void> fetchBooks() async {
    books = await _booksRepository.fetchAll();
    notifyListeners();
  }

  Future<void> delete({required Book book}) async {
    book.delete();
    notifyListeners();
  }
}
