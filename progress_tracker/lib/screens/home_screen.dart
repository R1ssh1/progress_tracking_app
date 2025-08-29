import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../widgets/progress_overview.dart';
import '../widgets/empty_state.dart';
import 'add_task_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Progress Tracker'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              _buildTodayTab(taskProvider),
              _buildAllTasksTab(taskProvider),
              _buildStatsTab(taskProvider),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.today),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'All Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'Stats',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTaskScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildTodayTab(TaskProvider taskProvider) {
    final availableTasks = taskProvider.availableTasks;
    final completedTasks = taskProvider.completedToday;
    final stats = taskProvider.getTaskStatistics();

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh data if needed
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview
            ProgressOverview(
              todayPoints: stats['todayPointsEarned'],
              dailyGoal: taskProvider.dailyGoal,
              completionRate: stats['completionRate'],
              totalPoints: stats['totalPointsEarned'],
            ),
            const SizedBox(height: 24),

            // Today's Date
            Text(
              DateFormat('EEEE, MMMM d').format(DateTime.now()),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Available Tasks
            if (availableTasks.isNotEmpty) ...[
              Text(
                'Available Tasks (${availableTasks.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...availableTasks.map((task) => TaskCard(task: task)),
              const SizedBox(height: 24),
            ],

            // Completed Tasks Today
            if (completedTasks.isNotEmpty) ...[
              Text(
                'Completed Today (${completedTasks.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...completedTasks.map((task) => TaskCard(
                task: task,
                isCompleted: true,
              )),
            ],

            // Empty State
            if (availableTasks.isEmpty && completedTasks.isEmpty) ...[
              const SizedBox(height: 40),
              EmptyState(
                icon: Icons.task_alt,
                title: 'No tasks for today',
                subtitle: 'Add some tasks to start tracking your progress!',
                actionText: 'Add Task',
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTaskScreen(),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAllTasksTab(TaskProvider taskProvider) {
    final tasks = taskProvider.tasks;
    final categories = taskProvider.categories;

    return DefaultTabController(
      length: categories.length + 1,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: [
              const Tab(text: 'All'),
              ...categories.map((category) => Tab(text: category)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // All Tasks Tab
                _buildTaskList(tasks),
                // Category Tabs
                ...categories.map((category) => 
                  _buildTaskList(taskProvider.getTasksByCategory(category))
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    if (tasks.isEmpty) {
      return const EmptyState(
        icon: Icons.task_alt,
        title: 'No tasks yet',
        subtitle: 'Create your first task to get started!',
        actionText: 'Add Task',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(task: task);
      },
    );
  }

  Widget _buildStatsTab(TaskProvider taskProvider) {
    final stats = taskProvider.getTaskStatistics();
    final tasks = taskProvider.tasks;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistics',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Points',
                  '${stats['totalPointsEarned']}',
                  Icons.stars,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Today\'s Points',
                  '${stats['todayPointsEarned']}',
                  Icons.today,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Tasks',
                  '${stats['totalTasks']}',
                  Icons.list,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Completion Rate',
                  '${(stats['completionRate'] * 100).toInt()}%',
                  Icons.check_circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Top Performing Tasks
          if (tasks.isNotEmpty) ...[
            Text(
              'Top Performing Tasks',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ..._getTopPerformingTasks(tasks).map((task) => _buildTopTaskCard(task)),
          ],

          // Recent Activity
          const SizedBox(height: 24),
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _buildRecentActivityList(tasks),
        ],
      ),
    );
  }

  List<Task> _getTopPerformingTasks(List<Task> tasks) {
    return tasks
        .where((task) => task.totalPointsEarned > 0)
        .toList()
      ..sort((a, b) => b.totalPointsEarned.compareTo(a.totalPointsEarned))
        ..take(5);
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTaskCard(Task task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            '${task.points}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(task.name),
        subtitle: Text('${task.totalPointsEarned} points earned'),
        trailing: Text(
          '${task.currentStreak} day streak',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  Widget _buildRecentActivityList(List<Task> tasks) {
    final recentTasks = tasks
        .where((task) => task.completedDates.isNotEmpty)
        .toList()
      ..sort((a, b) {
        final aLastCompleted = a.completedDates.reduce((x, y) => x.isAfter(y) ? x : y);
        final bLastCompleted = b.completedDates.reduce((x, y) => x.isAfter(y) ? x : y);
        return bLastCompleted.compareTo(aLastCompleted);
      });

    if (recentTasks.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No recent activity'),
        ),
      );
    }

    return Column(
      children: recentTasks.take(5).map((task) {
        final lastCompleted = task.completedDates.reduce((x, y) => x.isAfter(y) ? x : y);
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(task.name),
            subtitle: Text(
              'Completed ${DateFormat('MMM d, y').format(lastCompleted)}',
            ),
            trailing: Text(
              '+${task.points} pts',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
