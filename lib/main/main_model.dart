import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String appText = "本の紹介アプリです";

  void changeAppText() {
    appText = "カフェで勉強しよう！！";
    notifyListeners();
  }
}
