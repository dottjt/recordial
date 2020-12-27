import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  bool _showSongLongPress = false;
  bool get getShowSongLongPress { return _showSongLongPress; }
  void updateShowSongLongPress(bool value) {
    _showSongLongPress = value;
    notifyListeners();
  }
}
