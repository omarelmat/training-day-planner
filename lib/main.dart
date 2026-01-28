import 'package:flutter/material.dart';
import 'package:training_day_planner/widgets/task_screen.dart';
import 'package:training_day_planner/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // ← THIS FILE WAS JUST GENERATED

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with the generated options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await NotificationHelper.initialize();
  
  runApp(MaterialApp(
    home: TaskScreen(),
    theme: ThemeData(fontFamily: 'OpenSans'),
  ));
}