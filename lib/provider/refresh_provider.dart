import 'package:flutter/material.dart';

class RefreshProvider extends ChangeNotifier{
  bool _refresh = false;

  void doNotRefresh(){
    _refresh = false;
    notifyListeners();
  }

  void refreshPage() {
    _refresh = true;
    notifyListeners();
  }

  bool get getRefreshState => _refresh;
}