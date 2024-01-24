import 'dart:async';

import 'package:presentation/page_view_model.dart';

class SecondsCounterViewModel extends PageViewModel {
  int _seconds = 60;
  int get seconds => _seconds;

  SecondsCounterViewModel(super.context) {
    _seconds = DateTime.now().second;
    Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = 60 - DateTime.now().second;

      notifyListeners();
    });
  }
  ready() {}
}
