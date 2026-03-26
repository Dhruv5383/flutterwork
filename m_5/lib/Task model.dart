// lib/models/task_model.dart
// Task data model with SQLite mapping support

enum TaskStatus { pending, inProgress, completed }

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  String get value {
    switch (this) {
      case TaskStatus.pending:
        return 'pending';
      case TaskStatus.inProgress:
        return 'in_progress';
      case TaskStatus.completed:
        return 'completed';
    }
  }

  static TaskStatus fromString(String value) {
    switch (value) {
      case 'in_progress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      default:
        return TaskStatus.pending;
    }
  }
}

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskStatus status;
  final DateTime createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status = TaskStatus.pending,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Convert Task to a Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'status': status.value,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Create a Task from a SQLite Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      dueDate: DateTime.parse(map['due_date'] as String),
      status: TaskStatusExtension.fromString(map['status'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  /// Create a copy with updated fields
  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    TaskStatus? status,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isOverdue =>
      dueDate.isBefore(DateTime.now()) && status != TaskStatus.completed;

  @override
  String toString() =>
      'Task(id: $id, title: $title, status: ${status.value}, dueDate: $dueDate)';
}