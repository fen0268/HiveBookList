import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../domain/book.dart';
import '../../repository/books_repository.dart';
import '../add_book/add_book_page.dart';
import '../edit_book/edit_book_page.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final booksRepository = Provider.of<BooksRepository>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider(
      create: (_) => BookListModel(booksRepository)..fetchBookList(),
      child: Consumer<BookListModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('本一覧'),
            ),
            body: Center(
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
                                .then((_) => model.fetchBookList());
                          },
                          icon: Icons.edit,
                          label: '編集',
                          backgroundColor: Colors.black54,
                        ),
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            showConfirmDialog(context, book, model);
                          },
                          icon: Icons.delete,
                          label: '削除',
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.memory(
                        book.uInt!,
                        fit: BoxFit.fitHeight,
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => const AddBookPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => model.fetchBookList());
              },
              child: const Icon(Icons.add),
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
                model.delete(book);
                model.fetchBookList();
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
