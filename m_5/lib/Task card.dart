// lib/widgets/task_card.dart
// Reusable card widget for displaying a single Task

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import '../models/task_model.dart';
//import '../theme/app_theme.dart';
import 'App theme.dart';
import 'Task model.dart';

class TaskCard extends StatelessWidget {
  final Task          task;
  final VoidCallback  onTap;
  final VoidCallback  onDelete;
  final VoidCallback  onToggleStatus;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final theme      = Theme.of(context);
    final cs         = theme.colorScheme;
    final statusColor = AppTheme.statusColor(task.status.value);
    final isCompleted = task.status == TaskStatus.completed;
    final isOverdue   = task.isOverdue;

    return Dismissible(
      key:        ValueKey(task.id),
      direction:  DismissDirection.endToStart,
      background: _DismissBackground(),
      confirmDismiss: (_) async {
        onDelete();
        return false; // actual deletion handled by onDelete
      },
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status toggle button
                GestureDetector(
                  onTap: onToggleStatus,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width:  26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape:   BoxShape.circle,
                      color:   isCompleted
                          ? statusColor
                          : Colors.transparent,
                      border:  Border.all(
                        color: statusColor,
                        width: 2.2,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check_rounded,
                        size: 16, color: Colors.white)
                        : null,
                  ),
                ),

                const SizedBox(width: 14),

                // Title + description + meta
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.title,
                              style: TextStyle(
                                fontSize:       16,
                                fontWeight:     FontWeight.w700,
                                color:          cs.onSurface,
                                decoration:     isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor: cs.onSurface.withOpacity(0.4),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Status chip
                          _StatusChip(status: task.status),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Description
                      if (task.description.isNotEmpty)
                        Text(
                          task.description,
                          style: TextStyle(
                            fontSize: 13,
                            color:    cs.onSurface.withOpacity(0.6),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 10),

                      // Due date + overdue badge
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size:  13,
                            color: isOverdue
                                ? Colors.red
                                : cs.onSurface.withOpacity(0.45),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('MMM d, yyyy').format(task.dueDate),
                            style: TextStyle(
                              fontSize:   12,
                              fontWeight: FontWeight.w500,
                              color:      isOverdue
                                  ? Colors.red
                                  : cs.onSurface.withOpacity(0.5),
                            ),
                          ),
                          if (isOverdue) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color:        Colors.red.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Overdue',
                                style: TextStyle(
                                  fontSize:   10,
                                  fontWeight: FontWeight.w700,
                                  color:      Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Edit arrow
                const SizedBox(width: 8),
                Icon(Icons.chevron_right_rounded,
                    size: 20, color: cs.onSurface.withOpacity(0.3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final TaskStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.statusColor(status.value);
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color:        color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize:   10,
          fontWeight: FontWeight.w700,
          color:      color,
        ),
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.centerRight,
    padding:   const EdgeInsets.only(right: 20),
    margin:    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color:        Colors.red.shade400,
      borderRadius: BorderRadius.circular(16),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.delete_rounded, color: Colors.white),
        SizedBox(height: 4),
        Text('Delete',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600)),
      ],
    ),
  );
}