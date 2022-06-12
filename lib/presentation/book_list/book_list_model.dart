import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/book.dart';
import '../../repository/books_repository.dart';

final bookListProvider = ChangeNotifierProvider.family(
  (ref, BooksRepository booksRepository) => BookListModel(booksRepository),
);

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
