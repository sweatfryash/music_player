import 'package:flutter/cupertino.dart';

class IndexModel with ChangeNotifier {
  int _index = 1;
  bool onChangedLock = true;
  int get index => _index;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void lock() {
    onChangedLock = false;
    notifyListeners();
  }

  void unLock() {
    onChangedLock = true;
    notifyListeners();
  }
}
