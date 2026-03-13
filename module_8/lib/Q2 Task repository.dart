import 'package:hive_flutter/hive_flutter.dart';
import 'Q2 Task model.dart';
import 'Q2 Task modelg.dart';
//import 'Q2 Task modelg.dart';
//import 'task_model.dart';

// ─────────────────────────────────────────────
//  CONSTANTS
// ─────────────────────────────────────────────
const String kTaskBox = 'tasks';

// ─────────────────────────────────────────────
//  TASK REPOSITORY  –  all Hive CRUD in one place
// ─────────────────────────────────────────────
class TaskRepository {
  static Box<Task>? _box;

  // ── Initialise Hive + open box ───────────────
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters (safe to call even if already registered)
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(TaskAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(TaskPriorityAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(TaskCategoryAdapter());

    _box = await Hive.openBox<Task>(kTaskBox);
  }

  static Box<Task> get box {
    if (_box == null || !_box!.isOpen) {
      throw StateError('TaskRepository not initialised. Call init() first.');
    }
    return _box!;
  }

  // ── CREATE ───────────────────────────────────
  /// Adds a new task and returns it.
  static Future<Task> addTask({
    required String title,
    String description = '',
    DateTime? dueDate,
    TaskPriority priority = TaskPriority.medium,
    TaskCategory category = TaskCategory.personal,
  }) async {
    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      createdAt: DateTime.now(),
      dueDate: dueDate,
      priority: priority,
      category: category,
    );
    await box.put(task.id, task);
    return task;
  }

  // ── READ ─────────────────────────────────────
  /// Returns all tasks sorted by creation date (newest first).
  static List<Task> getAllTasks() {
    final tasks = box.values.toList();
    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return tasks;
  }

  /// Returns only incomplete tasks.
  static List<Task> getActiveTasks() =>
      getAllTasks().where((t) => !t.isCompleted).toList();

  /// Returns only completed tasks.
  static List<Task> getCompletedTasks() =>
      getAllTasks().where((t) => t.isCompleted).toList();

  /// Returns tasks filtered by category.
  static List<Task> getByCategory(TaskCategory cat) =>
      getAllTasks().where((t) => t.category == cat).toList();

  /// Returns tasks filtered by priority.
  static List<Task> getByPriority(TaskPriority p) =>
      getAllTasks().where((t) => t.priority == p).toList();

  /// Searches tasks by title or description (case-insensitive).
  static List<Task> search(String query) {
    final q = query.toLowerCase();
    return getAllTasks()
        .where((t) =>
    t.title.toLowerCase().contains(q) ||
        t.description.toLowerCase().contains(q))
        .toList();
  }

  // ── UPDATE ───────────────────────────────────
  /// Updates any fields of an existing task.
  static Future<void> updateTask(
      Task task, {
        String? title,
        String? description,
        DateTime? dueDate,
        TaskPriority? priority,
        TaskCategory? category,
      }) async {
    final updated = task.copyWith(
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
      category: category,
    );
    await box.put(task.id, updated);
  }

  /// Toggles the completed state and stamps completedAt.
  static Future<void> toggleComplete(Task task) async {
    final nowCompleted = !task.isCompleted;
    final updated = task.copyWith(
      isCompleted: nowCompleted,
      completedAt: nowCompleted ? DateTime.now() : null,
    );
    await box.put(task.id, updated);
  }

  // ── DELETE ───────────────────────────────────
  /// Deletes a single task by id.
  static Future<void> deleteTask(String id) async {
    await box.delete(id);
  }

  /// Deletes all completed tasks.
  static Future<int> clearCompleted() async {
    final ids = box.values
        .where((t) => t.isCompleted)
        .map((t) => t.id)
        .toList();
    await box.deleteAll(ids);
    return ids.length;
  }

  /// Deletes every task in the box.
  static Future<void> clearAll() async => box.clear();

  // ── STATS ────────────────────────────────────
  static Map<String, int> getStats() {
    final all       = box.values.toList();
    final completed = all.where((t) => t.isCompleted).length;
    final overdue   = all.where((t) => t.isOverdue).length;
    final today     = all.where((t) => t.isDueToday && !t.isCompleted).length;
    return {
      'total':     all.length,
      'active':    all.length - completed,
      'completed': completed,
      'overdue':   overdue,
      'today':     today,
    };
  }
}