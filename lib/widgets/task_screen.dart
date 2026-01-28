import 'package:training_day_planner/model/task.dart';
import 'package:training_day_planner/widgets/task_list.dart';
import 'package:training_day_planner/widgets/new_task.dart';
import 'package:flutter/material.dart';


class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});


  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}


class _TaskScreenState extends State<TaskScreen> {
  List<Task> myTasks = [
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


  void addNewTask(Task task) {
    setState(() {
      myTasks.add(task);
    });
  }


  void _deleteTask(Task task) {
    final taskIndex = myTasks.indexOf(task);


    setState(() {
      myTasks.remove(task);
    });


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