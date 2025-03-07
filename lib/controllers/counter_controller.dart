import 'package:flutter/material.dart';

class CounterController extends ChangeNotifier {
  int counter = 0;
  bool isLoading = false;

  increment() {
    if(counter == 10) {
      isLoading = true;
      notifyListeners();
      return;
    }
    counter ++;
    notifyListeners();
  }
  decrement() {
    counter --;
    notifyListeners();
  }
}