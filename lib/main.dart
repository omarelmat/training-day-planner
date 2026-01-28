import 'package:flutter/material.dart';
import 'widgets/expense_screen.dart';  // Rename to task_screen.dart later
import 'package:training_day_planner/notification_helper.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();
  
  runApp(MaterialApp(
    home: ExpenseScreen(),  // Rename class later
    theme: ThemeData(fontFamily: 'OpenSans'),
  ));
}