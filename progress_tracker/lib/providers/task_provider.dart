import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  AppTheme _currentTheme = AppTheme.lavender;
  int _totalPoints = 0;
  int _dailyGoal = 100;

  List<Task> get tasks => _tasks.where((task) => task.isActive).toList();
  List<Task> get allTasks => _tasks;
  AppTheme get currentTheme => _currentTheme;
  int get totalPoints => _totalPoints;
  int get dailyGoal => _dailyGoal;

  // Get tasks that can be completed today
  List<Task> get availableTasks => tasks.where((task) => task.canCompleteToday).toList();

  // Get tasks completed today
  List<Task> get completedToday {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    return tasks.where((task) => task.completedDates.any((date) =>
        date.year == todayDate.year &&
        date.month == todayDate.month &&
        date.day == todayDate.day)).toList();
  }

  // Get today's points
  int get todayPoints {
    return completedToday.fold(0, (sum, task) => sum + task.points);
  }

  // Get completion rate for today
  double get todayCompletionRate {
    if (availableTasks.isEmpty) return 1.0;
    return completedToday.length / availableTasks.length;
  }

  // Initialize provider
  Future<void> initialize() async {
    await loadTasks();
    await loadTheme();
    await loadSettings();
    _calculateTotalPoints();
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await saveTasks();
    notifyListeners();
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      await saveTasks();
      _calculateTotalPoints();
      notifyListeners();
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await saveTasks();
    _calculateTotalPoints();
    notifyListeners();
  }

  // Mark task as completed
  Future<void> completeTask(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      try {
        _tasks[index] = _tasks[index].markCompleted();
        await saveTasks();
        _calculateTotalPoints();
        notifyListeners();
      } catch (e) {
        // Task cannot be completed today
        rethrow;
      }
    }
  }

  // Toggle task active status
  Future<void> toggleTaskStatus(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(isActive: !_tasks[index].isActive);
      await saveTasks();
      _calculateTotalPoints();
      notifyListeners();
    }
  }

  // Update theme
  Future<void> updateTheme(AppTheme theme) async {
    _currentTheme = theme;
    await saveTheme();
    notifyListeners();
  }

  // Update daily goal
  Future<void> updateDailyGoal(int goal) async {
    _dailyGoal = goal;
    await saveSettings();
    notifyListeners();
  }

  // Calculate total points from all tasks
  void _calculateTotalPoints() {
    _totalPoints = _tasks.fold(0, (sum, task) => sum + task.totalPointsEarned);
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = _tasks.map((task) => task.toJson()).toList();
    await prefs.setString('tasks', jsonEncode(tasksJson));
  }

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final tasksJson = jsonDecode(tasksString) as List<dynamic>;
      _tasks = tasksJson.map((json) => Task.fromJson(json)).toList();
    }
  }

  // Save theme to SharedPreferences
  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', jsonEncode(_currentTheme.toJson()));
  }

  // Load theme from SharedPreferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme');
    if (themeString != null) {
      final themeJson = jsonDecode(themeString);
      _currentTheme = AppTheme.fromJson(themeJson);
    }
  }

  // Save settings to SharedPreferences
  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyGoal', _dailyGoal);
  }

  // Load settings from SharedPreferences
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyGoal = prefs.getInt('dailyGoal') ?? 100;
  }

  // Get tasks by category
  List<Task> getTasksByCategory(String category) {
    return tasks.where((task) => task.category == category).toList();
  }

  // Get all categories
  List<String> get categories {
    final categories = tasks.map((task) => task.category).toSet().toList();
    categories.sort();
    return categories;
  }

  // Get task statistics
  Map<String, dynamic> getTaskStatistics() {
    final totalTasks = tasks.length;
    final completedTasks = completedToday.length;
    final availableTasks = this.availableTasks.length;
    final totalPointsEarned = _totalPoints;
    final todayPointsEarned = todayPoints;

    return {
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'availableTasks': availableTasks,
      'totalPointsEarned': totalPointsEarned,
      'todayPointsEarned': todayPointsEarned,
      'completionRate': todayCompletionRate,
      'dailyGoalProgress': todayPointsEarned / _dailyGoal,
    };
  }

  // Reset all data (for testing or user request)
  Future<void> resetAllData() async {
    _tasks.clear();
    _totalPoints = 0;
    await saveTasks();
    notifyListeners();
  }
}
