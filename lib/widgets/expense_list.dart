import 'package:training_day_planner/model/expense.dart';
import 'package:training_day_planner/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final void Function(Expense expense) onRemoveExpense;
  List<Expense> expenses;

  ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return //ListView(children: [...],)
    ListView.builder(
      itemCount: expenses.length,

      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Colors.red.shade600,
          padding: EdgeInsets.only(left: 50),
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        //direction: DismissDirection.endToStart,
        secondaryBackground: Container(
          color: Colors.blue.shade600,
          padding: EdgeInsets.only(right: 50),
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index]),
      ),
      /* itemBuilder: (ctx, index) {
        return ExpenseItem(expense: expenses[index]);
      },*/
    );
  }
}
