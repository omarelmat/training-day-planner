import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat('dd MMMM yyyy');

enum TaskCategory { work, personal, fitness, training, meal } 

const Map<TaskCategory, IconData> categoryIcons = {
  TaskCategory.work: Icons.work_outline,         // Briefcase for work
  TaskCategory.personal: Icons.person_outline,   // Person for personal  
  TaskCategory.fitness: Icons.fitness_center,    // Dumbbell for fitness
  TaskCategory.training: Icons.sports_gymnastics, // Gymnastics for training
  TaskCategory.meal: Icons.restaurant_menu,      // Restaurant for meal
};




class Task {
  final String id;
  final String title;
  final double duration; // minutes instead of amount
  final DateTime date;
  final TaskCategory category;
  final String? photoPath;

  const Task({
    required this.id,
    required this.title,
    required this.duration,
    required this.date,
    required this.category,
    this.photoPath,
  });

  @override
  String toString() {
    return formatter.format(date).toString();
  }

  String get formattedDate => formatter.format(date);
}