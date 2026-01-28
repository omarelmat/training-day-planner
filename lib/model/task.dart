import 'package:flutter/material.dart';

enum TaskCategory {
  work,
  personal,
  fitness,
  training,
  meal;

  String get name {
    switch (this) {
      case TaskCategory.work: return 'Work';
      case TaskCategory.personal: return 'Personal';
      case TaskCategory.fitness: return 'Fitness';
      case TaskCategory.training: return 'Training';
      case TaskCategory.meal: return 'Meal';
    }
  }
}

class Task {
  final String id;
  final String title;
  final double duration;
  final DateTime date;
  final TaskCategory category;
  final String? photoPath;

  Task({
    required this.id,
    required this.title,
    required this.duration,
    required this.date,
    required this.category,
    this.photoPath,
  });

  // Get formatted date for display
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Convert Task to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'date': date.toIso8601String(),
      'category': category.index,
      'photoPath': photoPath,
    };
  }

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      duration: (json['duration'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      category: TaskCategory.values[json['category']],
      photoPath: json['photoPath'],
    );
  }
}

// Category icons map (add this outside the class)
final Map<TaskCategory, IconData> categoryIcons = {
  TaskCategory.work: Icons.work_outline,
  TaskCategory.personal: Icons.person_outline,
  TaskCategory.fitness: Icons.fitness_center,
  TaskCategory.training: Icons.sports_gymnastics,
  TaskCategory.meal: Icons.restaurant_menu,
};