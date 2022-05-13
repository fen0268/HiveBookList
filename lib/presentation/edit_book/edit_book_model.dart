import 'package:flutter/material.dart';

import '../../domain/book.dart';

class EditBookModel extends ChangeNotifier {
  final Book book;
  String? title;
  String? author;
  EditBookModel({required this.book}) {
    titleController.text = book.title;
    authorController.text = book.author;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  bool isOnPressed = false;

  void changeIsOnPressed() {
    isOnPressed = titleController.text.isNotEmpty;
    isOnPressed = titleController.text.isNotEmpty;
    notifyListeners();
  }

  Future<void> update({required Book book}) async {
    book.title = titleController.text;
    book.author = authorController.text;
    book.save();
    notifyListeners();
  }
}
