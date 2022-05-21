import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../domain/book.dart';
import '../../repository/books_repository.dart';
import '../add_book/add_book_page.dart';
import '../edit_book/edit_book_page.dart';
import 'book_list_model.dart';

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
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                Scrollbar(
                  child: ListView.builder(
                    itemCount: model.books.length,
                    itemBuilder: (context, index) {
                      final book = model.books[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) async {
                                await Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => EditBookPage(
                                          book: book,
                                        ),
                                      ),
                                    )
                                    .then((_) => model.fetchBooks());
                              },
                              icon: Icons.edit,
                              label: '編集',
                            ),
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                showConfirmDialog(context, book, model);
                              },
                              icon: Icons.delete,
                              label: '削除',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Image.memory(book.uInt!),
                          title: Text(book.title),
                          subtitle: Text(book.author),
                        ),
                      );
                    },
                  ),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future showConfirmDialog(
    BuildContext context,
    Book book,
    BookListModel model,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('本の削除'),
          content: Text('｢${book.title}」を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('いいえ'),
            ),
            TextButton(
              onPressed: () {
                model.delete(book: book);
                model.fetchBooks();
                Navigator.pop(context);
              },
              child: const Text('はい'),
            ),
          ],
        );
      },
    );
  }
}
