import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = "";
  String password = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp() async {
    if (mail.isEmpty) {
      throw ("メールアドレスを入力してください！");
      //バリデーション
    }

    if (password.isEmpty) {
      throw ("パスワードを入力してください！");
      //バリデーション
    }

    //todo;
    // ignore: deprecated_member_use
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    ))
        .user;
    final email = user.email;

    // ignore: deprecated_member_use
    Firestore.instance.collection('users').add(
      {
        'email': email,
        "createdAt": Timestamp.now(),
      },
    );
  }
}
