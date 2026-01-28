import 'package:training_day_planner/model/task.dart';  
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(Object context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Text("${task.duration.toStringAsFixed(0)} min"),
                Spacer(),
                Icon(categoryIcons[task.category], color: Colors.blue),  // ← This line uses categoryIcons
                SizedBox(width: 10),
                Text(task.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
