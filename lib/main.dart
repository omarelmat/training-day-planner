import 'package:flutter/material.dart';
import 'package:training_day_planner/widgets/task_screen.dart';
import 'package:training_day_planner/notification_helper.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();
  
  runApp(MaterialApp(
    home: TaskScreen(),
    theme: ThemeData(fontFamily: 'OpenSans'),
  ));
}
