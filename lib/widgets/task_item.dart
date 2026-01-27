import 'package:training_day_planner/model/task.dart';
import 'package:flutter/material.dart';
import 'dart:io'; 

class TaskItem extends StatelessWidget {
  final Task task; 

  const TaskItem({super.key, required this.task});

  @override
Widget build(BuildContext context) {
  return Semantics(
    label: 'Task: ${task.title} - ${task.duration.toStringAsFixed(0)} minutes on ${task.formattedDate}',
    hint: 'Double tap to view details',
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text("${task.duration.toStringAsFixed(0)} min"),
                if (task.photoPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(
                    File(task.photoPath!),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                Spacer(),
                Icon(Icons.fitness_center, color: Colors.blue),
                SizedBox(width: 10),
                Text(task.formattedDate),
              ],
            ),
          ],
        ),
      ),
    ),
  );
 }
}
