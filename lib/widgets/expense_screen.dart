import 'package:training_day_planner/model/expense.dart';
import 'package:training_day_planner/widgets/expense_item.dart';
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
  List<Expense> myExpenses = [
    Expense(
      title: "Polpa",
      amount: 2.50,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "English Dictionary",
      amount: 6.25,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void addNewExpense(Expense expense) {
    setState(() {
      myExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = myExpenses.indexOf(expense);

    setState(() {
      myExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              myExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void showAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      //ctx is the context of the bottom sheet
      //builder: (ctx){return Text("This is where the form will go");},
      builder: (ctx) => NewExpense(submitExpense: addNewExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expenses found.  Start Adding expenses"),
    );

    if (myExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: myExpenses,
        onRemoveExpense: _deleteExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: Text("Expense Tracker", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 247, 31, 67),
        actions: [
          IconButton(
            onPressed: showAddExpenseOverlay,
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),

      body: mainContent,

      /*Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...myExpenses.map((exp) {
            return ExpenseItem(expense: exp);
          }),
        ],
      ),*/
    );
  }
}
