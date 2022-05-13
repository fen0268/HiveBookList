import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/book.dart';
import 'edit_book_model.dart';

class EditBookPage extends StatelessWidget {
  const EditBookPage({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(book: book),
      child: Consumer<EditBookModel>(
        builder: (_, model, __) {
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
                    ElevatedButton(
                      onPressed: model.isOnPressed
                          ? () {
                              model.update(book: book);

                              Navigator.of(context).pop();
                            }
                          : null,
                      child: const Text('更新'),
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
