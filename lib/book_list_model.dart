import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_s_i_c/book.dart';
import 'package:flutter/material.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final docs =
        // ignore: deprecated_member_use
        await Firestore.instance.collection('books').getDocuments();
    final books = docs.documents.map((doc) => Book(doc["title"])).toList();
    this.books = books;
    notifyListeners();
  }
}
