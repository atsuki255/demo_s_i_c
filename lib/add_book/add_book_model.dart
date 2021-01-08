import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_s_i_c/book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = "";

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ("タイトルを入力してください！");
    }
    // ignore: deprecated_member_use
    Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        "createdAt": Timestamp.now(),
      },
    );
  }

  Future updateBook(Book book) async {
    final document =
        // ignore: deprecated_member_use
        Firestore.instance.collection("books").document(book.documentID);
    // ignore: deprecated_member_use
    await document.updateData(
      {
        'title': bookTitle,
        "updateAt": Timestamp.now(),
      },
    );
  }
}
