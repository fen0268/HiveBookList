import 'package:flutter/material.dart';
import 'package:hive_book_list_sample/domain/book.dart';
import 'package:hive_book_list_sample/repository/books_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'presentation/book_list/book_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Book>(BookAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BooksRepository>(create: (_) => BooksRepository(BooksBox()))
      ],
      child: const MaterialApp(
        home: BookListPage(),
      ),
    );
  }
}
