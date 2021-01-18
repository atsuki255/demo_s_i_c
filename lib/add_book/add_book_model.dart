import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_s_i_c/book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = "";
  File imageFile;

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ("タイトルを入力してください！");
    }

    final imageURL = await _uploadImage();
    // ignore: deprecated_member_use
    Firestore.instance.collection('books').add(
      {
        'title': bookTitle,
        "imageURL": imageURL,
        "createdAt": Timestamp.now(),
      },
    );
  }

  Future updateBook(Book book) async {
    final document =
        // ignore: deprecated_member_use
        Firestore.instance.collection("books").document(book.documentID);
    final imageURL = await _uploadImage();
    // ignore: deprecated_member_use
    await document.updateData(
      {
        'title': bookTitle,
        "imageURL": imageURL,
        "updateAt": Timestamp.now(),
      },
    );
  }

  Future<String> _uploadImage() async {
    //TODO:storageのアップロード
    return "https://xtech.nikkei.com/it/article/NEWS/20111006/370229/jobs_s.jpg?__scale=w:800,h:537&_sh=02403305f0";
  }
}
