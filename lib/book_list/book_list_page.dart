import 'package:demo_s_i_c/add_book/add_book_page.dart';
import 'package:demo_s_i_c/book_list/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("本一覧"),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map((book) => ListTile(
                      title: Text(book.title),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          //TODO:画面遷移

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBookPage(
                                book: book,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                          model.fetchBooks();
                        },
                      ),
                    ))
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              //TODO
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBooks();
              //本一覧ををもう一度リロードし、表示する
            },
          );
        }),
      ),
    );
  }
}
