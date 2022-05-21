import 'package:flutter/material.dart';
import 'package:hive_book_list_sample/presentation/add_book/add_book_model.dart';
import 'package:hive_book_list_sample/repository/books_repository.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookRepository = Provider.of<BooksRepository>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(
        bookRepository,
      ),
      child: Consumer<AddBookModel>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'タイトル',
                      ),
                      controller: model.titleController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (_) {
                        model.changeIsOnPressed();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'タイトルを入力してください。';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '著者',
                      ),
                      controller: model.authorController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (_) {
                        model.changeIsOnPressed();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '著者を入力してください。';
                        }

                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: model.uInt == null
                            ? const Text('画像を')
                            : Image.memory(model.uInt!),
                        onTap: () async {
                          await model.getImageFromGallery();
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: model.isOnPressed
                          ? () {
                              model.add();
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: const Text('追加'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
