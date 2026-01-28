import 'package:training_day_planner/model/task.dart';  
import 'package:flutter/material.dart';
import 'dart:io'; // KEEP THIS

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
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
                Icon(categoryIcons[task.category], color: Colors.blue),
                SizedBox(width: 10),
                Text(task.formattedDate),
              ],
            ),
           
            if (task.photoPath != null && task.photoPath!.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: 12),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(task.photoPath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}