import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'domain/book.dart';
import 'presentation/book_list/book_list_page.dart';
import 'repository/books_repository.dart';

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
