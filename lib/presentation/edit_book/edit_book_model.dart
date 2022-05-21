import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/book.dart';

class EditBookModel extends ChangeNotifier {
  final Book book;
  String? title;
  String? author;
  Uint8List? uInt;
  EditBookModel({required this.book}) {
    titleController.text = book.title;
    authorController.text = book.author;
    uInt = book.uInt;
  }

  final picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  bool isOnPressed = true;

  void changeIsOnPressed() {
    isOnPressed = titleController.text.isNotEmpty;
    isOnPressed = titleController.text.isNotEmpty;
    notifyListeners();
  }

  Future<void> update({required Book book}) async {
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
