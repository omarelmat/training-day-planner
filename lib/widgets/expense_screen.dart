import 'package:training_day_planner/model/task.dart';
import 'package:training_day_planner/widgets/expense_list.dart';
import 'package:training_day_planner/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseScreenState();
  }
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Task> myTasks = [
    Task(
      id: '1',
      title: "Kickboxing Session",
      duration: 45.0,
      date: DateTime.now(),
      category: TaskCategory.training,
    ),
    Task(
      id: '2',
      title: "Code Flutter",
      duration: 120.0,
      date: DateTime.now(),
      category: TaskCategory.work,
    ),
  ];

  void addNewExpense(Task task) {
    setState(() {
      myTasks.add(task);
    });
  }

  void _deleteExpense(Task task) {
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

  void showAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(submitExpense: addNewExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Tasks found. Start Adding tasks"),
    );

    if (myTasks.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: myTasks,
        onRemoveExpense: _deleteExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Training Day Planner", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 247, 31, 67),
        actions: [
          IconButton(
            onPressed: showAddExpenseOverlay,
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
