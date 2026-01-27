import 'package:flutter/material.dart';
import 'widgets/expense_screen.dart';  // Rename to task_screen.dart later

void main() {
  runApp(MaterialApp(
    home: ExpenseScreen(),  // Rename class later
    theme: ThemeData(fontFamily: 'OpenSans'),
  ));
}