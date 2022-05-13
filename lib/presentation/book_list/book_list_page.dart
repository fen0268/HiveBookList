import 'package:flutter/material.dart';
import 'package:hive_book_list_sample/presentation/book_list/book_list_model.dart';
import 'package:hive_book_list_sample/repository/books_repository.dart';
import 'package:provider/provider.dart';

import '../add_book/add_book_page.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booksRepository = Provider.of<BooksRepository>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider(
      create: (_) => BookListModel(booksRepository)..fetchBooks(),
      child: Consumer<BookListModel>(
        builder: (_, model, __) {
          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                Scrollbar(
                  child: ListView.builder(
                      itemCount: model.books.length,
                      itemBuilder: (context, index) {
                        final book = model.books[index];
                        return ListTile(
                          title: Text(book.title),
                          subtitle: Text(book.author),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              model.delete(book: book);
                              model.fetchBooks();
                            },
                          ),
                        );
                      }),
                ),
                Positioned(
                    bottom: 50,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => const AddBookPage(),
                                fullscreenDialog: true,
                              ),
                            )
                            .then((_) => model.fetchBooks());
                      },
                      child: const Icon(Icons.add),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
