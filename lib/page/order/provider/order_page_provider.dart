import 'package:flutter/material.dart';

// 在provider中继承ChangeNotfier
class OrderPageProvider extends ChangeNotifier {

  int _index = 0;
  int get index => _index;

  void refresh() {
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
