import 'package:training_day_planner/model/task.dart';
import 'package:training_day_planner/widgets/task_list.dart';
import 'package:training_day_planner/widgets/new_task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 
import 'package:training_day_planner/firebase_analytics_helper.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> myTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
    FirebaseAnalyticsHelper.logScreenView('TaskListScreen');
  }

  // FIXED: Load actual tasks, not just count
  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getString('tasks_data');
      
      if (tasksJson != null && tasksJson.isNotEmpty) {
        // Parse JSON to get actual tasks
        final List<dynamic> decoded = json.decode(tasksJson);
        final loadedTasks = decoded.map((json) => Task.fromJson(json)).toList();
        
        setState(() {
          myTasks = loadedTasks;
        });
        print('Loaded ${myTasks.length} tasks from storage');
      } else {
        // If no saved tasks, show sample tasks
        setState(() {
          myTasks = [
            Task(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: "Kickboxing Session",
              duration: 45.0,
              date: DateTime.now(),
              category: TaskCategory.fitness,
            ),
            Task(
              id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
              title: "Code Flutter",
              duration: 120.0,
              date: DateTime.now(),
              category: TaskCategory.work,
            ),
          ];
        });
        _saveTasks(); // Save sample tasks
      }
    } catch (e) {
      print('Error loading tasks: $e');
      // Show sample tasks on error
      setState(() {
        myTasks = [
          Task(
            id: '1',
            title: "Kickboxing Session",
            duration: 45.0,
            date: DateTime.now(),
            category: TaskCategory.fitness,
          ),
          Task(
            id: '2',
            title: "Code Flutter",
            duration: 120.0,
            date: DateTime.now(),
            category: TaskCategory.work,
          ),
        ];
      });
    }
  }

  // FIXED: Save actual tasks as JSON
  Future<void> _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert tasks to JSON
      final tasksJson = myTasks.map((task) => task.toJson()).toList();
      final encoded = json.encode(tasksJson);
      
      await prefs.setString('tasks_data', encoded);
      print(' Saved ${myTasks.length} tasks to storage');
    } catch (e) {
      print(' Error saving tasks: $e');
    }
  }

  void addNewTask(Task task) {
    setState(() {
      myTasks.add(task);
    });
    _saveTasks(); // Save after adding
    FirebaseAnalyticsHelper.logTaskCreated(
    task.title,
    task.duration,
    task.category.name,
  );
  }

  void _deleteTask(Task task) {
    final taskIndex = myTasks.indexOf(task);

    setState(() {
      myTasks.remove(task);
    }); 

    _saveTasks(); // Save after deleting

    FirebaseAnalyticsHelper.logTaskDeleted(task.title, task.duration);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Task Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              myTasks.insert(taskIndex, task);
            });
            _saveTasks(); // Save after undo
          },
        ),
      ),
    );
  }

  void showAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(submitTask: addNewTask),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Tasks found. Start planning your day!"),
    );

    if (myTasks.isNotEmpty) {
      mainContent = TaskList(
        tasks: myTasks,
        onRemoveTask: _deleteTask,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Day Planner", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 59, 130, 246),
        actions: [
          IconButton(
            onPressed: showAddTaskOverlay,
            icon: Semantics(
              label: 'Add new task',
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}