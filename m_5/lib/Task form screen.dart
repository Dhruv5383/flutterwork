// lib/screens/task_form_screen.dart
// Add / Edit task form with validation and date picker

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//mport '../database/database_helper.dart';
//import '../models/task_model.dart';
import 'Database helper.dart';
import 'Task model.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? existingTask;

  const TaskFormScreen({super.key, this.existingTask});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey         = GlobalKey<FormState>();
  final DatabaseHelper _db = DatabaseHelper();

  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;

  DateTime    _dueDate   = DateTime.now().add(const Duration(days: 1));
  TaskStatus  _status    = TaskStatus.pending;
  bool        _isSaving  = false;

  bool get _isEditing => widget.existingTask != null;

  @override
  void initState() {
    super.initState();
    final task = widget.existingTask;
    _titleCtrl = TextEditingController(text: task?.title ?? '');
    _descCtrl  = TextEditingController(text: task?.description ?? '');
    if (task != null) {
      _dueDate = task.dueDate;
      _status  = task.status;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context:     context,
      initialDate: _dueDate,
      firstDate:   DateTime.now().subtract(const Duration(days: 365)),
      lastDate:    DateTime.now().add(const Duration(days: 3 * 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      if (_isEditing) {
        final updated = widget.existingTask!.copyWith(
          title:       _titleCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          dueDate:     _dueDate,
          status:      _status,
        );
        await _db.updateTask(updated);
      } else {
        final newTask = Task(
          title:       _titleCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          dueDate:     _dueDate,
          status:      _status,
        );
        await _db.insertTask(newTask);
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      _showError('Failed to save task. Please try again.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final cs     = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Task' : 'New Task',
          style: theme.appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // ── Title ──────────────────────────────
              _SectionLabel('Task Title'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleCtrl,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 80,
                decoration: const InputDecoration(
                  hintText: 'e.g. Design homepage mockup',
                  prefixIcon: Icon(Icons.title_rounded),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Title is required';
                  if (v.trim().length < 3)           return 'Title too short (min 3 chars)';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ── Description ────────────────────────
              _SectionLabel('Description'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descCtrl,
                maxLines: 4,
                maxLength: 500,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Add details about the task…',
                  alignLabelWithHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 64),
                    child: Icon(Icons.description_rounded),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Description is required';
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ── Due Date ───────────────────────────
              _SectionLabel('Due Date'),
              const SizedBox(height: 8),
              _DueDatePicker(
                dueDate:  _dueDate,
                onTap:    _pickDate,
                colorScheme: cs,
              ),

              const SizedBox(height: 24),

              // ── Status ─────────────────────────────
              _SectionLabel('Status'),
              const SizedBox(height: 12),
              _StatusSelector(
                selected: _status,
                onChanged: (s) => setState(() => _status = s),
                colorScheme: cs,
              ),

              const SizedBox(height: 36),

              // ── Save button ────────────────────────
              SizedBox(
                height: 52,
                child: FilledButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: _isSaving
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                      : Icon(_isEditing
                      ? Icons.save_rounded
                      : Icons.add_task_rounded),
                  label: Text(
                    _isSaving
                        ? 'Saving…'
                        : _isEditing
                        ? 'Update Task'
                        : 'Add Task',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helper widgets ───────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      letterSpacing: 0.5,
    ),
  );
}

class _DueDatePicker extends StatelessWidget {
  final DateTime dueDate;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _DueDatePicker({
    required this.dueDate,
    required this.onTap,
    required this.colorScheme,
  });

  bool get _isOverdue => dueDate.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final color = _isOverdue ? Colors.red : colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withOpacity(0.25),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded, size: 20, color: color),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMMM d, yyyy').format(dueDate),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: color,
                  ),
                ),
                if (_isOverdue)
                  Text(
                    'This date is in the past',
                    style: TextStyle(fontSize: 11, color: Colors.red.shade400),
                  ),
              ],
            ),
            const Spacer(),
            Icon(Icons.edit_calendar_rounded, size: 18, color: color.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}

class _StatusSelector extends StatelessWidget {
  final TaskStatus selected;
  final ValueChanged<TaskStatus> onChanged;
  final ColorScheme colorScheme;

  const _StatusSelector({
    required this.selected,
    required this.onChanged,
    required this.colorScheme,
  });

  static const _options = [
    (TaskStatus.pending,    '⏳ Pending',     Color(0xFFFFB300)),
    (TaskStatus.inProgress, '🔵 In Progress', Color(0xFF4F6AF5)),
    (TaskStatus.completed,  '✅ Completed',   Color(0xFF26C36F)),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _options.map((opt) {
        final (status, label, color) = opt;
        final isSelected = selected == status;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(status),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? color : colorScheme.outline.withOpacity(0.3),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? color
                      : colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}