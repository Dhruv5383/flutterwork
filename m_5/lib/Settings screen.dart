// lib/screens/settings_screen.dart
// User preferences: theme mode, username, default filter, data management

import 'package:flutter/material.dart';
//import '../services/preferences_service.dart';
//import '../database/database_helper.dart';
import 'Database helper.dart';
import 'Preferences service.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode currentThemeMode;
  final ValueChanged<String> onUsernameChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeToggle,
    required this.currentThemeMode,
    required this.onUsernameChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final PreferencesService _prefs = PreferencesService();
  final DatabaseHelper     _db    = DatabaseHelper();

  late ThemeMode _themeMode;
  String _username      = '';
  String _defaultFilter = 'all';
  bool   _isLoading     = true;

  final _usernameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _themeMode = widget.currentThemeMode;
    _loadSettings();
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);
    _username      = await _prefs.getUsername();
    _defaultFilter = await _prefs.getDefaultFilter();
    _usernameCtrl.text = _username;
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _saveUsername() async {
    final name = _usernameCtrl.text.trim();
    if (name.isEmpty) return;
    await _prefs.saveUsername(name);
    widget.onUsernameChanged(name);
    setState(() => _username = name);
    _showSnack('✅ Name updated to "$name"');
    FocusScope.of(context).unfocus();
  }

  Future<void> _changeTheme(ThemeMode mode) async {
    await _prefs.saveThemeMode(mode);
    setState(() => _themeMode = mode);
    widget.onThemeToggle();
  }

  Future<void> _clearCompleted() async {
    final confirmed = await _showConfirmDialog(
      'Clear Completed Tasks',
      'This will permanently delete all completed tasks. This cannot be undone.',
      'Clear',
      Colors.orange,
    );
    if (!confirmed) return;
    final count = await _db.deleteCompletedTasks();
    _showSnack('🗑️ Deleted $count completed task${count == 1 ? '' : 's'}');
  }

  Future<void> _resetAllData() async {
    final confirmed = await _showConfirmDialog(
      'Reset All Data',
      'This will delete ALL tasks and reset your preferences. This cannot be undone.',
      'Reset',
      Colors.red,
    );
    if (!confirmed) return;
    // Close and reopen DB to wipe all tasks
    final allTasks = await _db.getAllTasks();
    for (final t in allTasks) {
      if (t.id != null) await _db.deleteTask(t.id!);
    }
    await _prefs.clearAll();
    _showSnack('🔄 All data has been reset');
    if (mounted) Navigator.pop(context);
  }

  Future<bool> _showConfirmDialog(
      String title,
      String content,
      String confirmLabel,
      Color confirmColor,
      ) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: confirmColor),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(confirmLabel),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: theme.appBarTheme.titleTextStyle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Profile section ──────────────────────
          _SectionHeader('Profile'),
          _SettingsCard(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Display Name',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface.withOpacity(0.55))),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _usernameCtrl,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              hintText: 'Your name',
                              prefixIcon: Icon(Icons.person_rounded),
                            ),
                            onSubmitted: (_) => _saveUsername(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        FilledButton(
                          onPressed: _saveUsername,
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Appearance ───────────────────────────
          _SectionHeader('Appearance'),
          _SettingsCard(
            children: [
              _ThemeTile(
                mode:       ThemeMode.light,
                selected:   _themeMode,
                label:      'Light',
                icon:       Icons.light_mode_rounded,
                onTap:      () => _changeTheme(ThemeMode.light),
              ),
              const Divider(height: 1, indent: 56),
              _ThemeTile(
                mode:       ThemeMode.dark,
                selected:   _themeMode,
                label:      'Dark',
                icon:       Icons.dark_mode_rounded,
                onTap:      () => _changeTheme(ThemeMode.dark),
              ),
              const Divider(height: 1, indent: 56),
              _ThemeTile(
                mode:       ThemeMode.system,
                selected:   _themeMode,
                label:      'System Default',
                icon:       Icons.brightness_auto_rounded,
                onTap:      () => _changeTheme(ThemeMode.system),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Default filter ───────────────────────
          _SectionHeader('Task View'),
          _SettingsCard(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.filter_list_rounded, color: cs.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Default Filter',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text('Which tasks to show on launch',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: cs.onSurface.withOpacity(0.55))),
                        ],
                      ),
                    ),
                    DropdownButton<String>(
                      value: _defaultFilter,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(value: 'all',         child: Text('All')),
                        DropdownMenuItem(value: 'pending',     child: Text('Pending')),
                        DropdownMenuItem(value: 'in_progress', child: Text('In Progress')),
                        DropdownMenuItem(value: 'completed',   child: Text('Completed')),
                      ],
                      onChanged: (v) async {
                        if (v == null) return;
                        await _prefs.saveDefaultFilter(v);
                        setState(() => _defaultFilter = v);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Data management ──────────────────────
          _SectionHeader('Data Management'),
          _SettingsCard(
            children: [
              _ActionTile(
                icon:       Icons.check_circle_outline_rounded,
                iconColor:  Colors.orange,
                label:      'Clear Completed Tasks',
                subtitle:   'Remove all tasks marked as done',
                onTap:      _clearCompleted,
              ),
              const Divider(height: 1, indent: 56),
              _ActionTile(
                icon:       Icons.delete_forever_rounded,
                iconColor:  Colors.red,
                label:      'Reset All Data',
                subtitle:   'Delete all tasks and preferences',
                onTap:      _resetAllData,
                labelColor: Colors.red,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // ── App info ─────────────────────────────
          Center(
            child: Column(
              children: [
                Text('TaskMate',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: cs.primary)),
                const SizedBox(height: 4),
                Text('v1.0.0 • by TaskNest Solutions',
                    style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurface.withOpacity(0.4))),
                const SizedBox(height: 4),
                Text('All data stored offline on your device',
                    style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurface.withOpacity(0.35))),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Helper widgets ───────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(children: children),
    ),
  );
}

class _ThemeTile extends StatelessWidget {
  final ThemeMode mode, selected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ThemeTile({
    required this.mode,
    required this.selected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs        = Theme.of(context).colorScheme;
    final isSelected = mode == selected;
    return ListTile(
      leading: Icon(icon, color: isSelected ? cs.primary : null),
      title: Text(label,
          style: TextStyle(
              fontWeight:
              isSelected ? FontWeight.w700 : FontWeight.w500)),
      trailing: isSelected
          ? Icon(Icons.check_circle_rounded, color: cs.primary)
          : null,
      onTap: onTap,
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final Color? labelColor;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: iconColor),
    title: Text(label,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: labelColor)),
    subtitle: Text(subtitle,
        style: TextStyle(
            fontSize: 12,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(0.55))),
    onTap: onTap,
  );
}