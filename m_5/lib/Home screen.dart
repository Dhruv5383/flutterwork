// lib/screens/home_screen.dart
// Main dashboard: task list with filter tabs, stats banner, and FAB

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import '../database/database_helper.dart';
//import '../models/task_model.dart';
//import '../services/preferences_service.dart';
import 'Database helper.dart';
import 'Preferences service.dart';
import 'Settings screen.dart';
import 'Stats banner.dart';
import 'Task card.dart';
import 'Task form screen.dart';
import 'Task model.dart';
//import 'task_form_screen.dart';
//import 'settings_screen.dart';
//import '../widgets/task_card.dart';
//import '../widgets/stats_banner.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode currentThemeMode;

  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.currentThemeMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final DatabaseHelper   _db    = DatabaseHelper();
  final PreferencesService _prefs = PreferencesService();

  late TabController _tabController;

  List<Task> _allTasks     = [];
  Map<String, int> _stats  = {'pending': 0, 'in_progress': 0, 'completed': 0};
  bool _isLoading          = true;
  String _searchQuery      = '';
  String _username         = 'Freelancer';

  final List<String> _filters      = ['All', 'Pending', 'In Progress', 'Completed'];
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _filters.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    try {
      _username = await _prefs.getUsername();
      await _refreshTasks();
    } catch (e) {
      _showError('Failed to load tasks');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshTasks() async {
    final tasks = _searchQuery.isNotEmpty
        ? await _db.searchTasks(_searchQuery)
        : await _db.getAllTasks();
    final stats = await _db.getTaskStats();
    if (mounted) {
      setState(() {
        _allTasks = tasks;
        _stats    = stats;
      });
    }
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
    setState(() {});
  }

  List<Task> get _filteredTasks {
    switch (_tabController.index) {
      case 1: return _allTasks.where((t) => t.status == TaskStatus.pending).toList();
      case 2: return _allTasks.where((t) => t.status == TaskStatus.inProgress).toList();
      case 3: return _allTasks.where((t) => t.status == TaskStatus.completed).toList();
      default: return _allTasks;
    }
  }

  Future<void> _navigateToForm({Task? task}) async {
    await _prefs.saveLastScreen('task_form');
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => TaskFormScreen(existingTask: task)),
    );
    if (result == true) {
      await _refreshTasks();
      _showSnack(task == null ? '✅ Task added!' : '✏️ Task updated!');
    }
    await _prefs.saveLastScreen('home');
  }

  Future<void> _deleteTask(Task task) async {
    final confirmed = await _showDeleteDialog(task.title);
    if (!confirmed) return;
    await _db.deleteTask(task.id!);
    await _refreshTasks();
    _showSnack('🗑️ "${task.title}" deleted');
  }

  Future<void> _toggleStatus(Task task) async {
    final next = task.status == TaskStatus.completed
        ? TaskStatus.pending
        : task.status == TaskStatus.pending
        ? TaskStatus.inProgress
        : TaskStatus.completed;
    await _db.updateTaskStatus(task.id!, next);
    await _refreshTasks();
  }

  Future<bool> _showDeleteDialog(String title) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Task?',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ??
        false;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme   = Theme.of(context);
    final isDark  = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$_greeting, $_username 👋',
                style: theme.appBarTheme.titleTextStyle),
            Text(
              DateFormat('EEEE, MMM d').format(DateTime.now()),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurface.withOpacity(0.55),
              ),
            ),
          ],
        ),
        toolbarHeight: 72,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            tooltip: 'Toggle theme',
            onPressed: widget.onThemeToggle,
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Settings',
            onPressed: () async {
              await _prefs.saveLastScreen('settings');
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    onThemeToggle: widget.onThemeToggle,
                    currentThemeMode: widget.currentThemeMode,
                    onUsernameChanged: (name) {
                      setState(() => _username = name);
                    },
                  ),
                ),
              );
              await _prefs.saveLastScreen('home');
            },
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search tasks…',
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        _searchCtrl.clear();
                        setState(() => _searchQuery = '');
                        _refreshTasks();
                      },
                    )
                        : null,
                  ),
                  onChanged: (v) {
                    setState(() => _searchQuery = v);
                    _refreshTasks();
                  },
                ),
              ),
              // Filter tabs
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: _filters
                    .map((f) => Tab(
                  child: Text(f,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _refreshTasks,
        child: CustomScrollView(
          slivers: [
            // Stats banner
            SliverToBoxAdapter(
              child: StatsBanner(
                pending:    _stats['pending']    ?? 0,
                inProgress: _stats['in_progress'] ?? 0,
                completed:  _stats['completed']  ?? 0,
              ),
            ),

            // Empty state
            if (_filteredTasks.isEmpty)
              SliverFillRemaining(
                child: _EmptyState(isSearch: _searchQuery.isNotEmpty),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (ctx, i) {
                    final task = _filteredTasks[i];
                    return TaskCard(
                      task: task,
                      onTap:    () => _navigateToForm(task: task),
                      onDelete: () => _deleteTask(task),
                      onToggleStatus: () => _toggleStatus(task),
                    );
                  },
                  childCount: _filteredTasks.length,
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(),
        icon:  const Icon(Icons.add_rounded),
        label: const Text('New Task',
            style: TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isSearch;
  const _EmptyState({required this.isSearch});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearch ? Icons.search_off_rounded : Icons.task_alt_rounded,
            size: 72,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            isSearch ? 'No tasks match your search' : 'No tasks yet!',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            isSearch
                ? 'Try different keywords'
                : 'Tap + to add your first task',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}