import 'package:flutter/foundation.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final int points;
  final int frequency; // Days between completions (1 = daily, 2 = every other day, etc.)
  final DateTime createdAt;
  final List<DateTime> completedDates;
  final String category;
  final bool isActive;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.frequency,
    required this.createdAt,
    List<DateTime>? completedDates,
    this.category = 'General',
    this.isActive = true,
  }) : completedDates = completedDates ?? [];

  // Get total points earned from this task
  int get totalPointsEarned => completedDates.length * points;

  // Get completion streak
  int get currentStreak {
    if (completedDates.isEmpty) return 0;
    
    final sortedDates = List<DateTime>.from(completedDates)..sort();
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    int streak = 0;
    DateTime? currentDate = todayDate;
    
    while (sortedDates.isNotEmpty) {
      final lastCompleted = sortedDates.last;
      final lastCompletedDate = DateTime(lastCompleted.year, lastCompleted.month, lastCompleted.day);
      
      if (currentDate == null) {
        currentDate = lastCompletedDate;
      }
      
      if (currentDate.difference(lastCompletedDate).inDays <= frequency) {
        streak++;
        sortedDates.removeLast();
        currentDate = lastCompletedDate.subtract(Duration(days: frequency));
      } else {
        break;
      }
    }
    
    return streak;
  }

  // Check if task can be completed today
  bool get canCompleteToday {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    // Check if already completed today
    if (completedDates.any((date) => 
        date.year == todayDate.year && 
        date.month == todayDate.month && 
        date.day == todayDate.day)) {
      return false;
    }
    
    // Check frequency constraint
    if (completedDates.isNotEmpty) {
      final lastCompleted = completedDates.reduce((a, b) => a.isAfter(b) ? a : b);
      final lastCompletedDate = DateTime(lastCompleted.year, lastCompleted.month, lastCompleted.day);
      final daysSinceLastCompletion = todayDate.difference(lastCompletedDate).inDays;
      
      if (daysSinceLastCompletion < frequency) {
        return false;
      }
    }
    
    return true;
  }

  // Mark task as completed
  Task markCompleted() {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    if (!canCompleteToday) {
      throw Exception('Task cannot be completed today');
    }
    
    final newCompletedDates = List<DateTime>.from(completedDates)..add(todayDate);
    
    return Task(
      id: id,
      name: name,
      description: description,
      points: points,
      frequency: frequency,
      createdAt: createdAt,
      completedDates: newCompletedDates,
      category: category,
      isActive: isActive,
    );
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'points': points,
      'frequency': frequency,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'completedDates': completedDates.map((date) => date.millisecondsSinceEpoch).toList(),
      'category': category,
      'isActive': isActive,
    };
  }

  // Create from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      points: json['points'],
      frequency: json['frequency'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      completedDates: (json['completedDates'] as List<dynamic>)
          .map((date) => DateTime.fromMillisecondsSinceEpoch(date))
          .toList(),
      category: json['category'] ?? 'General',
      isActive: json['isActive'] ?? true,
    );
  }

  // Create a copy with modified properties
  Task copyWith({
    String? id,
    String? name,
    String? description,
    int? points,
    int? frequency,
    DateTime? createdAt,
    List<DateTime>? completedDates,
    String? category,
    bool? isActive,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      points: points ?? this.points,
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
      completedDates: completedDates ?? this.completedDates,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Task(id: $id, name: $name, points: $points, frequency: $frequency)';
  }
}
