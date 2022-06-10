import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/book.dart';

class EditBookModel extends ChangeNotifier {
  final Book book;
  String? title;
  String? author;
  Uint8List? uInt;
  EditBookModel(this.book) {
    titleController.text = book.title;
    authorController.text = book.author;
    uInt = book.uInt;
  }

  final picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  bool isOnPressed = false;

  void changeIsOnPressed() {
    isOnPressed = titleController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
        uInt != null;
    notifyListeners();
  }

  Future<void> update(Book book) async {
    book.title = titleController.text;
    book.author = authorController.text;
    book.uInt = uInt;
    book.save();
    notifyListeners();
  }

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    uInt = await pickedFile.readAsBytes();
    notifyListeners();
  }
}
