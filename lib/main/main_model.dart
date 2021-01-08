
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String appText = "カフェ情報共有アプリです";

  void changeAppText(){
    appText = "カフェで勉強しよう！！";
    notifyListeners();
  }
}