import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/books_repository.dart';
import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

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
            appBar: AppBar(
              title: const Text('本を追加'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      child: model.uInt == null
                          ? Stack(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  width: 120,
                                  height: 150,
                                ),
                                const Text('画像を選択を\nしてください'),
                              ],
                            )
                          : SizedBox(
                              width: 120,
                              height: 150,
                              child: Image.memory(
                                model.uInt!,
                                fit: BoxFit.fill,
                              ),
                            ),
                      onTap: () async {
                        await model.getImageFromGallery();
                        model.changeIsOnPressed();
                      },
                    ),
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
                    ElevatedButton(
                      onPressed: model.isOnPressed
                          ? () {
                              model.addBook();
                              const snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('本を追加しました'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
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
