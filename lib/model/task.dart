import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat('dd MMMM yyyy');

enum TaskCategory { training, work, personal, meal, fitness }

const Map<TaskCategory, IconData> categoryIcons = {
  TaskCategory.training: Icons.fitness_center,
  TaskCategory.work: Icons.code,
  TaskCategory.personal: Icons.person,
  TaskCategory.meal: Icons.restaurant,
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