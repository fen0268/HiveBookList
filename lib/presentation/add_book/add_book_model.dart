import 'package:flutter/material.dart';
import 'package:hive_book_list_sample/repository/books_repository.dart';

class AddBookModel extends ChangeNotifier {
  AddBookModel(BooksRepository booksRepository) {
    _booksRepository = booksRepository;
  }
  late BooksRepository _booksRepository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  bool isOnPressed = false;

  Future<void> add() async {
    await _booksRepository.add(
        title: titleController.text, author: authorController.text);
    notifyListeners();
  }

  void changeIsOnPressed() {
    isOnPressed = titleController.text.isNotEmpty;
    isOnPressed = titleController.text.isNotEmpty;
    notifyListeners();
  }
}
