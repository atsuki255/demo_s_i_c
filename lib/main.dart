import 'package:demo_s_i_c/book_list_page.dart';
import 'package:demo_s_i_c/main_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Studying-in-Cafe"),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                    model.appText,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  RaisedButton(
                    child: Text("ボタン"),
                    onPressed: () {
                      //ボタンを押すと何かする
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookListPage()),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
