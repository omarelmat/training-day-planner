import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_day_planner/model/task.dart';
import 'dart:convert';

class TaskStorage {
  static const String _tasksKey = 'saved_tasks';

  // Save tasks to SharedPreferences
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert tasks to JSON
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    final encoded = json.encode(tasksJson);
    
    await prefs.setString(_tasksKey, encoded);
    print('Saved ${tasks.length} tasks to storage');
  }

  // Load tasks from SharedPreferences
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_tasksKey);
    
    if (encoded == null) {
      print('No saved tasks found');
      return []; // Return empty list if no saved data
    }
    
    try {
      final List<dynamic> decoded = json.decode(encoded);
      final tasks = decoded.map((json) => Task.fromJson(json)).toList();
      print('Loaded ${tasks.length} tasks from storage');
      return tasks;
    } catch (e) {
      print(' Error loading tasks: $e');
      return [];
    }
  }

  // Clear all saved tasks
  static Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
    print(' Cleared all saved tasks');
  }
}