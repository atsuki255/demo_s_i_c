import 'package:demo_s_i_c/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../book.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({this.book}); //{}の囲みがあることでbookに値が入っていなくても対応可
  final Book book;
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = book != null;
    //bookがnullでなければ。。。（bookの中に何か入っていれば）

    final textEditingController = TextEditingController();
    if (isUpdate) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? "本を編集" : "本を追加"), //isUpdateがtrueであれば本を編集
        ),
        body: Consumer<AddBookModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 160,
                    child: InkWell(
                      onTap: () async {
                        await model.showImagePicker();
                        //todo:カメラロールを開く
                      },
                      child: model.imageFile != null
                          ? Image.file(model.imageFile)
                          : Container(
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  TextField(
                    controller: textEditingController,
                    onChanged: (text) {
                      model.bookTitle = text;
                    },
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? "更新する" : "追加する"),
                    onPressed: () async {
                      if (isUpdate) {
                        await updateBook(model, context);
                      } else {
                        //firestoreに本を追加
                        await addBook(model, context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future addBook(AddBookModel model, BuildContext context) async {
    try {
      await model.addBookToFirebase();

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました！'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
      //tryが成功すれば前の画面に戻る
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    //tryが成功しなければcatchが実行され、バリーデーションの文章が表示される
  }

  Future updateBook(AddBookModel model, BuildContext context) async {
    try {
      await model.updateBook(book);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新しました！'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
      //tryが成功すれば前の画面に戻る
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    //tryが成功しなければcatchが実行され、バリーデーションの文章が表示される
  }
}
