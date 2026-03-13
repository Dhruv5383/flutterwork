import 'package:hive/hive.dart';

//part 'task_modelg.dart';

// ─────────────────────────────────────────────
//  ENUMS
// ─────────────────────────────────────────────

@HiveType(typeId: 1)
enum TaskPriority {
  @HiveField(0)
  low,

  @HiveField(1)
  medium,

  @HiveField(2)
  high,
}

@HiveType(typeId: 2)
enum TaskCategory {
  @HiveField(0)
  personal,

  @HiveField(1)
  work,

  @HiveField(2)
  shopping,

  @HiveField(3)
  health,

  @HiveField(4)
  other,
}

// ─────────────────────────────────────────────
//  TASK MODEL
// ─────────────────────────────────────────────

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime? dueDate;

  @HiveField(6)
  TaskPriority priority;

  @HiveField(7)
  TaskCategory category;

  @HiveField(8)
  DateTime? completedAt;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.category = TaskCategory.personal,
    this.completedAt,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    TaskPriority? priority,
    TaskCategory? category,
    DateTime? completedAt,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate!.year == now.year &&
        dueDate!.month == now.month &&
        dueDate!.day == now.day;
  }
}