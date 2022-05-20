import 'package:flutter/material.dart';
import 'package:hive_book_list_sample/repository/books_repository.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  AddBookModel(BooksRepository booksRepository) {
    _booksRepository = booksRepository;
  }
  late BooksRepository _booksRepository;

  final picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  bool isOnPressed = false;

  Future<void> add() async {
    await _booksRepository.add(
      title: titleController.text,
      author: authorController.text,
    );
    notifyListeners();
  }
  //
  // Future<void> getImageFromGallery() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile == null) {
  //     return;
  //   }
  //   notifyListeners();
  // }

  void changeIsOnPressed() {
    isOnPressed = titleController.text.isNotEmpty;
    isOnPressed = authorController.text.isNotEmpty;

    notifyListeners();
  }
}
