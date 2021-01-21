import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future Login() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
      //バリデーション
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください');
      //バリデーション
    }

    // todo
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );

    final uid = result.user.uid;
    //todo端末に保存する
  }
}
