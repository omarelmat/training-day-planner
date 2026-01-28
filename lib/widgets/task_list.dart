import 'package:training_day_planner/model/task.dart';
import 'package:training_day_planner/widgets/task_item.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {  // ← Changed from ExpenseList
  final void Function(Task task) onRemoveTask;  // ← Changed parameter name
  final List<Task> tasks;  // ← Changed from expenses

  TaskList({  // ← Changed from ExpenseList
    super.key,
    required this.tasks,  // ← Changed from expenses
    required this.onRemoveTask,  // ← Changed from onRemoveExpense
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,  // ← Changed from expenses
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Colors.red.shade600,
          padding: EdgeInsets.only(left: 50),
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.blue.shade600,
          padding: EdgeInsets.only(right: 50),
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        key: ValueKey(tasks[index]),  // ← Changed from expenses
        onDismissed: (direction) {
          onRemoveTask(tasks[index]);  // ← Changed from onRemoveExpense
        },
        child: TaskItem(task: tasks[index]),  // ← Changed from expenses
      ),
    );
  }
}
