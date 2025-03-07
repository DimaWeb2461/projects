import 'package:flutter/material.dart';

class DateController extends ChangeNotifier {
  DateTime? selectedDate;

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void clearDate() {
    selectedDate = null;
    notifyListeners();
  }
}
