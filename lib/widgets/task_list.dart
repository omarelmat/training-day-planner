import 'package:training_day_planner/model/task.dart';
import 'package:training_day_planner/widgets/task_item.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {  
  final void Function(Task task) onRemoveTask; 
  final List<Task> tasks;  

  const TaskList({  
    super.key,
    required this.tasks,  
    required this.onRemoveTask,  
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,  
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
        key: ValueKey(tasks[index]),  
        onDismissed: (direction) {
          onRemoveTask(tasks[index]);  
        },
        child: Semantics(
          label: "Task ${tasks[index].title} - ${tasks[index].duration.toStringAsFixed(0)} minutes",
          hint: "Swipe left to delete this task",
          child: TaskItem(task: tasks[index]),
        ),
      ),
    );
  }
}