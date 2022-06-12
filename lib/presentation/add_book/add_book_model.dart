import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../repository/books_repository.dart';

final addBookProvider = ChangeNotifierProvider.family(
  (ref, BooksRepository booksRepository) => AddBookModel(booksRepository),
);

class AddBookModel extends ChangeNotifier {
  AddBookModel(
    BooksRepository booksRepository,
  ) {
    _booksRepository = booksRepository;
  }
  late BooksRepository _booksRepository;

  Uint8List? uInt;
  final picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  bool isOnPressed = false;

  Future<void> addBook() async {
    await _booksRepository.add(
      title: titleController.text,
      author: authorController.text,
      uInt: uInt,
    );
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

  void changeIsOnPressed() {
    isOnPressed = titleController.text.isNotEmpty &&
        authorController.text.isNotEmpty &&
        uInt != null;
    notifyListeners();
  }
}
