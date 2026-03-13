import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'Q1 Pref service.dart' show AppColors;
import 'Q2 App theme.dart';
import 'Q2 Task model.dart';
import 'Q2 Task repository.dart';
// import 'task_model.dart';
// import 'task_repository.dart';
// import 'app_theme.dart';

// ─────────────────────────────────────────────
//  TASK FORM BOTTOM SHEET
//  Used for both ADD and EDIT.
//  Pass [task] to pre-populate fields for editing.
// ─────────────────────────────────────────────
class TaskFormSheet extends StatefulWidget {
  const TaskFormSheet({super.key, this.task});

  /// If non-null, the form opens in EDIT mode.
  final Task? task;

  static Future<bool> show(BuildContext ctx, {Task? task}) async {
    final result = await showModalBottomSheet<bool>(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TaskFormSheet(task: task),
    );
    return result ?? false;
  }

  @override
  State<TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends State<TaskFormSheet> {
  final _formKey   = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl  = TextEditingController();

  TaskPriority _priority = TaskPriority.medium;
  TaskCategory _category = TaskCategory.personal;
  DateTime?    _dueDate;
  bool         _saving   = false;

  bool get _isEdit => widget.task != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      final t = widget.task!;
      _titleCtrl.text = t.title;
      _descCtrl.text  = t.description;
      _priority       = t.priority;
      _category       = t.category;
      _dueDate        = t.dueDate;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  // ── Submit ────────────────────────────────────
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    HapticFeedback.lightImpact();

    try {
      if (_isEdit) {
        await TaskRepository.updateTask(
          widget.task!,
          title:       _titleCtrl.text,
          description: _descCtrl.text,
          dueDate:     _dueDate,
          priority:    _priority,
          category:    _category,
        );
      } else {
        await TaskRepository.addTask(
          title:       _titleCtrl.text,
          description: _descCtrl.text,
          dueDate:     _dueDate,
          priority:    _priority,
          category:    _category,
        );
      }
      if (mounted) Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.dark(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(22, 8, 22, bottom + 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(top: 8, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(2),
              ),
            )),

            // Title
            Text(_isEdit ? 'Edit Task' : 'New Task',
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),

            // Task title field
            TextFormField(
              controller: _titleCtrl,
              autofocus: !_isEdit,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Task title *',
                prefixIcon: Icon(Icons.task_alt_rounded, color: AppColors.primary),
              ),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Title is required' : null,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 14),

            // Description field
            TextFormField(
              controller: _descCtrl,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              minLines: 1,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Icon(Icons.notes_rounded, color: Colors.white38),
                ),
                alignLabelWithHint: true,
              ),
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 18),

            // ── Priority ──
            _label('Priority'),
            const SizedBox(height: 8),
            Row(children: TaskPriority.values.map((p) {
              final sel = p == _priority;
              return Expanded(child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _priority = p),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: sel ? p.color.withOpacity(0.2) : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: sel ? p.color : AppColors.cardBorder,
                        width: sel ? 1.5 : 1,
                      ),
                    ),
                    child: Column(children: [
                      Icon(p.icon, color: sel ? p.color : Colors.white38, size: 18),
                      const SizedBox(height: 4),
                      Text(p.label,
                          style: TextStyle(
                              color: sel ? p.color : Colors.white38,
                              fontSize: 11, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ));
            }).toList()),

            const SizedBox(height: 18),

            // ── Category ──
            _label('Category'),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8,
              children: TaskCategory.values.map((cat) {
                final sel = cat == _category;
                return GestureDetector(
                  onTap: () => setState(() => _category = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: sel ? cat.color.withOpacity(0.15) : AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: sel ? cat.color : AppColors.cardBorder,
                        width: sel ? 1.5 : 1,
                      ),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(cat.icon,
                          color: sel ? cat.color : Colors.white38, size: 14),
                      const SizedBox(width: 6),
                      Text(cat.label,
                          style: TextStyle(
                              color: sel ? cat.color : Colors.white38,
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            // ── Due Date ──
            _label('Due Date'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(children: [
                  Icon(Icons.calendar_today_outlined,
                      color: _dueDate != null
                          ? AppColors.primary : Colors.white38,
                      size: 18),
                  const SizedBox(width: 10),
                  Expanded(child: Text(
                    _dueDate != null
                        ? DateFormat('EEE, d MMM yyyy').format(_dueDate!)
                        : 'No due date',
                    style: TextStyle(
                        color: _dueDate != null ? Colors.white : Colors.white38,
                        fontSize: 14),
                  )),
                  if (_dueDate != null)
                    GestureDetector(
                      onTap: () => setState(() => _dueDate = null),
                      child: const Icon(Icons.close_rounded,
                          color: Colors.white38, size: 18),
                    ),
                ]),
              ),
            ),

            const SizedBox(height: 24),

            // ── Submit button ──
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: _saving
                    ? const SizedBox(width: 20, height: 20,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                    : Text(_isEdit ? 'Update Task' : 'Add Task',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          color: Colors.white54, fontSize: 11,
          fontWeight: FontWeight.w700, letterSpacing: 0.8));
}