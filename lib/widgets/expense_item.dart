import 'package:training_day_planner/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(Object context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          spacing: 15,
          children: [
            Text(expense.title, style: TextStyle(fontWeight: FontWeight.bold)),

            Row(
              children: [
                //amount to 2 decimal places
                Text("€${expense.amount.toStringAsFixed(2)}"),
                Spacer(),
                Icon(categoryIcons[expense.category], color: Colors.blue),
                SizedBox(width: 10),
                Text(expense.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
