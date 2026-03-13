import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Q2 App theme.dart';
import 'Q2 Task card.dart';
import 'Q2 Task form sheet.dart';
import 'Q2 Task model.dart';
import 'Q2 Task repository.dart';
// import 'task_model.dart';
// import 'task_repository.dart';
// import 'task_form_sheet.dart';
// import 'task_card.dart';
// import 'app_theme.dart';

// ─────────────────────────────────────────────
//  FILTER ENUM
// ─────────────────────────────────────────────
enum TaskFilter { all, active, completed }

// ─────────────────────────────────────────────
//  HOME SCREEN
// ─────────────────────────────────────────────
class Q2HomeScreen extends StatefulWidget {
  const Q2HomeScreen({super.key});

  @override
  State<Q2HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Q2HomeScreen>
    with SingleTickerProviderStateMixin {
  TaskFilter _filter   = TaskFilter.all;
  String     _search   = '';
  bool       _showSearch = false;
  late final TextEditingController _searchCtrl;
  late final AnimationController   _fabAnim;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
    _fabAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..forward();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _fabAnim.dispose();
    super.dispose();
  }

  // ── Derived list ─────────────────────────────
  List<Task> _getFilteredTasks() {
    List<Task> tasks;
    switch (_filter) {
      case TaskFilter.all:       tasks = TaskRepository.getAllTasks();       break;
      case TaskFilter.active:    tasks = TaskRepository.getActiveTasks();    break;
      case TaskFilter.completed: tasks = TaskRepository.getCompletedTasks(); break;
    }
    if (_search.isNotEmpty) {
      final q = _search.toLowerCase();
      tasks = tasks
          .where((t) =>
      t.title.toLowerCase().contains(q) ||
          t.description.toLowerCase().contains(q))
          .toList();
    }
    return tasks;
  }

  void _refresh() => setState(() {});

  // ── Add task ─────────────────────────────────
  Future<void> _addTask() async {
    final added = await TaskFormSheet.show(context);
    if (added) _refresh();
  }

  // ── Clear completed ──────────────────────────
  Future<void> _clearCompleted() async {
    final count = TaskRepository.getCompletedTasks().length;
    if (count == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No completed tasks to clear')));
      return;
    }
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear completed tasks?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        content: Text('This will delete $count completed task${count == 1 ? '' : 's'}.',
            style: const TextStyle(color: Colors.white60)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.white54))),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Clear',
                  style: TextStyle(
                      color: AppColors.danger, fontWeight: FontWeight.w700))),
        ],
      ),
    );
    if (ok == true) {
      final deleted = await TaskRepository.clearCompleted();
      _refresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$deleted task${deleted == 1 ? '' : 's'} removed'),
          backgroundColor: AppColors.danger.withOpacity(0.9),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: TaskRepository.box.listenable(),
          builder: (ctx, _, __) {
            final tasks = _getFilteredTasks();
            final stats = TaskRepository.getStats();
            return Column(children: [
              _buildHeader(stats),
              _buildFilterBar(),
              if (_showSearch) _buildSearchBar(),
              Expanded(child: _buildList(tasks)),
            ]);
          },
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(parent: _fabAnim, curve: Curves.elasticOut),
        child: FloatingActionButton.extended(
          onPressed: _addTask,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Task',
              style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }

  // ── Header with stats ────────────────────────
  Widget _buildHeader(Map<String, int> stats) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('My Tasks',
                  style: TextStyle(color: Colors.white, fontSize: 26,
                      fontWeight: FontWeight.w800, letterSpacing: -0.5)),
              const SizedBox(height: 2),
              Text('${stats['active']} active · ${stats['completed']} done',
                  style: const TextStyle(color: Colors.white38, fontSize: 13)),
            ])),
            // Search toggle
            _iconBtn(
              icon: _showSearch ? Icons.search_off_rounded : Icons.search_rounded,
              onTap: () => setState(() {
                _showSearch = !_showSearch;
                if (!_showSearch) { _search = ''; _searchCtrl.clear(); }
              }),
            ),
            const SizedBox(width: 8),
            // More menu
            PopupMenuButton<String>(
              color: AppColors.card,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              icon: const Icon(Icons.more_vert_rounded, color: Colors.white54),
              onSelected: (v) {
                if (v == 'clear') _clearCompleted();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'clear',
                    child: Row(children: [
                      Icon(Icons.delete_sweep_rounded,
                          color: AppColors.danger, size: 18),
                      SizedBox(width: 10),
                      Text('Clear completed',
                          style: TextStyle(color: AppColors.danger)),
                    ])),
              ],
            ),
          ]),

          const SizedBox(height: 16),

          // Stats chips
          if (stats['total']! > 0)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                if (stats['today']! > 0)
                  _statChip('${stats['today']} due today',
                      AppColors.warning, Icons.today_rounded),
                if (stats['overdue']! > 0) ...[
                  const SizedBox(width: 8),
                  _statChip('${stats['overdue']} overdue',
                      AppColors.danger, Icons.warning_amber_rounded),
                ],
              ]),
            ),
        ],
      ),
    );
  }

  Widget _statChip(String label, Color color, IconData icon) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 13, color: color),
      const SizedBox(width: 5),
      Text(label,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );

  // ── Filter bar ───────────────────────────────
  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 0),
      child: Row(children: TaskFilter.values.map((f) {
        final labels = {
          TaskFilter.all: 'All',
          TaskFilter.active: 'Active',
          TaskFilter.completed: 'Done',
        };
        final active = f == _filter;
        return Expanded(child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => setState(() => _filter = f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: active ? AppColors.primary : AppColors.cardBorder,
                ),
              ),
              child: Text(labels[f]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: active ? Colors.white : Colors.white38,
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ));
      }).toList()),
    );
  }

  // ── Search bar ───────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 0),
      child: TextField(
        controller: _searchCtrl,
        autofocus: true,
        style: const TextStyle(color: Colors.white),
        onChanged: (v) => setState(() => _search = v),
        decoration: InputDecoration(
          hintText: 'Search tasks…',
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38),
          suffixIcon: _search.isNotEmpty
              ? GestureDetector(
              onTap: () => setState(() { _search = ''; _searchCtrl.clear(); }),
              child: const Icon(Icons.close_rounded, color: Colors.white38))
              : null,
        ),
      ),
    );
  }

  // ── Task list ────────────────────────────────
  Widget _buildList(List<Task> tasks) {
    if (tasks.isEmpty) return _buildEmpty();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 120),
      itemCount: tasks.length,
      itemBuilder: (_, i) => TaskCard(
        key: Key(tasks[i].id),
        task: tasks[i],
        onChanged: _refresh,
      ),
    );
  }

  // ── Empty state ──────────────────────────────
  Widget _buildEmpty() {
    final isSearch = _search.isNotEmpty;
    return Center(child: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isSearch ? Icons.search_off_rounded : Icons.checklist_rounded,
            color: AppColors.primary, size: 38,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          isSearch ? 'No tasks match "$_search"' : _emptyLabel,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          isSearch ? 'Try a different search term.' : _emptySubLabel,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white30, fontSize: 13),
        ),
        if (!isSearch) ...[
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addTask,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add your first task'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 14),
            ),
          ),
        ],
      ]),
    ));
  }

  String get _emptyLabel {
    switch (_filter) {
      case TaskFilter.all:       return 'No tasks yet';
      case TaskFilter.active:    return 'All caught up!';
      case TaskFilter.completed: return 'Nothing completed yet';
    }
  }

  String get _emptySubLabel {
    switch (_filter) {
      case TaskFilter.all:       return 'Tap the button below to create one.';
      case TaskFilter.active:    return 'Create a new task to get started.';
      case TaskFilter.completed: return 'Complete a task to see it here.';
    }
  }

  Widget _iconBtn({required IconData icon, required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Icon(icon, color: Colors.white54, size: 20),
        ),
      );
}