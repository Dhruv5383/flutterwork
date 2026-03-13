import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'Q2 App theme.dart';
import 'Q2 Task form sheet.dart';
import 'Q2 Task model.dart';
import 'Q2 Task repository.dart';
// import 'task_model.dart';
// import 'task_repository.dart';
// import 'task_form_sheet.dart';
// import 'app_theme.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onChanged,
  });

  final Task task;
  final VoidCallback onChanged;

  Future<void> _toggle(BuildContext ctx) async {
    HapticFeedback.selectionClick();
    await TaskRepository.toggleComplete(task);
    onChanged();
  }

  Future<void> _delete(BuildContext ctx) async {
    final ok = await showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete task?',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        content: Text('This will permanently delete "${task.title}".',
            style: const TextStyle(color: Colors.white60)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete',
                  style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w700))),
        ],
      ),
    );
    if (ok == true) {
      await TaskRepository.deleteTask(task.id);
      onChanged();
    }
  }

  Future<void> _edit(BuildContext ctx) async {
    final changed = await TaskFormSheet.show(ctx, task: task);
    if (changed) onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final completed = task.isCompleted;
    final accent    = task.priority.color;

    return Dismissible(
      key: Key(task.id),
      background: _swipeBackground(
          alignment: Alignment.centerLeft,
          color: AppColors.success,
          icon: completed ? Icons.undo_rounded : Icons.check_rounded,
          label: completed ? 'Undo' : 'Done'),
      secondaryBackground: _swipeBackground(
          alignment: Alignment.centerRight,
          color: AppColors.danger,
          icon: Icons.delete_outline_rounded,
          label: 'Delete'),
      confirmDismiss: (dir) async {
        if (dir == DismissDirection.startToEnd) {
          await _toggle(context);
          return false; // card rebuilds, not removed from list
        } else {
          await _delete(context);
          return false;
        }
      },
      child: GestureDetector(
        onTap: () => _edit(context),
        onLongPress: () {
          HapticFeedback.heavyImpact();
          _delete(context);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: completed
                  ? AppColors.cardBorder
                  : accent.withOpacity(0.3),
              width: completed ? 1 : 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Priority stripe ──
              Container(
                width: 4,
                height: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: completed ? Colors.transparent : accent,
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(18)),
                ),
              ),

              // ── Checkbox ──
              GestureDetector(
                onTap: () => _toggle(context),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 14, 4, 14),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      color: completed ? AppColors.success : Colors.transparent,
                      border: Border.all(
                        color: completed
                            ? AppColors.success
                            : Colors.white24,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: completed
                        ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 14)
                        : null,
                  ),
                ),
              ),

              // ── Content ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 14, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + edit icon
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.title,
                              style: TextStyle(
                                color: completed
                                    ? Colors.white30
                                    : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                decoration: completed
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor: Colors.white30,
                              ),
                            ),
                          ),
                          Icon(Icons.edit_outlined,
                              color: Colors.white24, size: 14),
                        ],
                      ),

                      // Description
                      if (task.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 13, height: 1.4),
                        ),
                      ],

                      const SizedBox(height: 10),

                      // ── Tags row ──
                      Wrap(spacing: 6, runSpacing: 6, children: [
                        // Category badge
                        _badge(
                          icon: task.category.icon,
                          label: task.category.label,
                          color: task.category.color,
                        ),
                        // Due date badge
                        if (task.dueDate != null)
                          _badge(
                            icon: task.isOverdue
                                ? Icons.warning_amber_rounded
                                : Icons.calendar_today_rounded,
                            label: _formatDueDate(task.dueDate!),
                            color: task.isOverdue
                                ? AppColors.danger
                                : task.isDueToday
                                ? AppColors.warning
                                : Colors.white38,
                          ),
                        // Completed-at badge
                        if (completed && task.completedAt != null)
                          _badge(
                            icon: Icons.check_circle_outline_rounded,
                            label: DateFormat('d MMM').format(task.completedAt!),
                            color: AppColors.success,
                          ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDueDate(DateTime d) {
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date  = DateTime(d.year, d.month, d.day);
    final diff  = date.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';
    if (diff < 0) return '${(-diff)}d overdue';
    return DateFormat('d MMM').format(d);
  }

  Widget _badge({
    required IconData icon,
    required String label,
    required Color color,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ]),
      );

  Widget _swipeBackground({
    required AlignmentGeometry alignment,
    required Color color,
    required IconData icon,
    required String label,
  }) =>
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        alignment: alignment,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w700)),
        ]),
      );
}