import 'package:flutter/material.dart';

class Utils {
  int getRemainingDays() {
    DateTime today = DateTime.now();
    int totalDaysOfCurrentMonth = DateTime(today.year, today.month + 1, 0).day;
    return totalDaysOfCurrentMonth - today.day;
  }

  String getMonth() {
    DateTime today = DateTime.now();
    return "${today.month}-${today.year}";
  }
}
