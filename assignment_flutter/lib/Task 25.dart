// 1
// import 'package:flutter/material.dart';
//
// class TodoApp extends StatefulWidget {
//   const TodoApp({super.key});
//
//   @override
//   State<TodoApp> createState() => _TodoAppState();
// }
//
// class _TodoAppState extends State<TodoApp> {
//   final TextEditingController taskController = TextEditingController();
//   final List<String> tasks = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("To-Do List")),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//
//             // ---------------- ADD TASK SECTION ----------------
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: taskController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: "Enter a task",
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (taskController.text.isNotEmpty) {
//                       setState(() {
//                         tasks.add(taskController.text);
//                         taskController.clear();
//                       });
//                     }
//                   },
//                   child: const Text("Add"),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 20),
//
//             // ---------------- TASK LIST ----------------
//             Expanded(
//               child: ListView.builder(
//                 itemCount: tasks.length,
//                 itemBuilder: (context, index) {
//                   return Dismissible(
//                     key: Key(tasks[index]),
//                     direction: DismissDirection.endToStart,
//                     onDismissed: (direction) {
//                       setState(() {
//                         tasks.removeAt(index);
//                       });
//                     },
//                     background: Container(
//                       color: Colors.red,
//                       alignment: Alignment.centerRight,
//                       padding: const EdgeInsets.only(right: 20),
//                       child: const Icon(Icons.delete, color: Colors.white),
//                     ),
//                     child: Card(
//                       child: ListTile(
//                         title: Text(tasks[index]),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//2
// import 'package:flutter/material.dart';
//
// class TodoApp extends StatefulWidget {
//   const TodoApp({super.key});
//
//   @override
//   State<TodoApp> createState() => _TodoAppState();
// }
//
// class _TodoAppState extends State<TodoApp> {
//   TextEditingController taskController = TextEditingController();
//
//   // List of tasks
//   List<Map<String, dynamic>> tasks = [];
//
//   // Add new task
//   void addTask() {
//     if (taskController.text.trim().isEmpty) return;
//
//     setState(() {
//       tasks.add({
//         "title": taskController.text.trim(),
//         "completed": false,
//       });
//     });
//
//     taskController.clear();
//     Navigator.pop(context); // close bottom sheet
//   }
//
//   // Edit task dialog
//   void editTask(int index) {
//     TextEditingController editController =
//     TextEditingController(text: tasks[index]["title"]);
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Edit Task"),
//         content: TextField(
//           controller: editController,
//           decoration: const InputDecoration(hintText: "Enter new task name"),
//         ),
//         actions: [
//           TextButton(
//             child: const Text("Cancel"),
//             onPressed: () => Navigator.pop(context),
//           ),
//           TextButton(
//             child: const Text("Save"),
//             onPressed: () {
//               setState(() {
//                 tasks[index]["title"] = editController.text.trim();
//               });
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Bottom sheet for adding task
//   void openAddTaskSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (_) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 16,
//           right: 16,
//           top: 20,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("Add Task",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextField(
//               controller: taskController,
//               decoration: const InputDecoration(
//                 hintText: "Enter task name",
//               ),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               onPressed: addTask,
//               child: const Text("Add"),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("To-Do List App"),
//         centerTitle: true,
//       ),
//
//       body: tasks.isEmpty
//           ? const Center(
//         child: Text(
//           "No tasks yet. Add one!",
//           style: TextStyle(fontSize: 18),
//         ),
//       )
//           : ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           return Dismissible(
//             key: Key(tasks[index]["title"]),
//             background: Container(
//               color: Colors.red,
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.only(left: 20),
//               child: const Icon(Icons.delete, color: Colors.white),
//             ),
//             secondaryBackground: Container(
//               color: Colors.red,
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.only(right: 20),
//               child: const Icon(Icons.delete, color: Colors.white),
//             ),
//             onDismissed: (direction) {
//               setState(() {
//                 tasks.removeAt(index);
//               });
//             },
//             child: ListTile(
//               title: Text(
//                 tasks[index]["title"],
//                 style: TextStyle(
//                   fontSize: 18,
//                   decoration: tasks[index]["completed"]
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                 ),
//               ),
//               leading: Checkbox(
//                 value: tasks[index]["completed"],
//                 onChanged: (value) {
//                   setState(() {
//                     tasks[index]["completed"] = value!;
//                   });
//                 },
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.edit),
//                 onPressed: () => editTask(index),
//               ),
//             ),
//           );
//         },
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: openAddTaskSheet,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// 3 final code
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleFileTodoApp extends StatefulWidget {
  const SingleFileTodoApp({super.key});

  @override
  State<SingleFileTodoApp> createState() => _SingleFileTodoAppState();
}

class _SingleFileTodoAppState extends State<SingleFileTodoApp> {
  // ---------- Models ----------
  // Simple Task model used only inside this file
  // Fields: id, title, notes, category, priority, dueDate, completed
  List<Map<String, dynamic>> tasks = [];

  // UI state
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  bool showCompleted = true;
  ThemeMode themeMode = ThemeMode.light;

  // categories & priorities
  final List<String> categories = ['Work', 'Personal', 'Shopping'];
  final List<String> priorities = ['High', 'Medium', 'Low'];

  // For Add/Edit
  String selectedCategory = 'Work';
  String selectedPriority = 'Medium';
  DateTime? selectedDueDate;
  bool isEditing = false;
  String editingId = '';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  // ---------- Persistence ----------
  static const String prefsKey = 'todo_tasks_v1';
  static const String prefsThemeKey = 'todo_theme_v1';

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(prefsKey);
    final themeStr = prefs.getString(prefsThemeKey);

    if (raw != null) {
      final List<dynamic> decoded = jsonDecode(raw);
      setState(() {
        tasks = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    }

    if (themeStr != null) {
      setState(() {
        themeMode = themeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
      });
    }
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefsKey, jsonEncode(tasks));
    await prefs.setString(prefsThemeKey, themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  // ---------- Task helpers ----------
  String _newId() => DateTime.now().millisecondsSinceEpoch.toString();

  void addTaskFromInput() {
    final title = _taskController.text.trim();
    if (title.isEmpty) return;

    final task = {
      'id': _newId(),
      'title': title,
      'notes': '',
      'category': selectedCategory,
      'priority': selectedPriority,
      'dueDate': selectedDueDate?.toIso8601String(),
      'completed': false,
      'createdAt': DateTime.now().toIso8601String(),
    };

    setState(() {
      tasks.insert(0, task);
      _taskController.clear();
      selectedDueDate = null;
      selectedCategory = categories.first;
      selectedPriority = 'Medium';
    });

    _savePrefs();
    Navigator.of(context).pop(); // close bottom sheet
  }

  void editTaskSave() {
    final title = _taskController.text.trim();
    if (title.isEmpty) return;

    setState(() {
      final idx = tasks.indexWhere((t) => t['id'] == editingId);
      if (idx >= 0) {
        tasks[idx]['title'] = title;
        tasks[idx]['category'] = selectedCategory;
        tasks[idx]['priority'] = selectedPriority;
        tasks[idx]['dueDate'] = selectedDueDate?.toIso8601String();
      }
      isEditing = false;
      editingId = '';
      _taskController.clear();
      selectedDueDate = null;
    });

    _savePrefs();
    Navigator.of(context).pop(); // close dialog/bottomsheet
  }

  void startEditTask(Map<String, dynamic> task) {
    setState(() {
      isEditing = true;
      editingId = task['id'] as String;
      _taskController.text = task['title'] ?? '';
      selectedCategory = task['category'] ?? categories.first;
      selectedPriority = task['priority'] ?? 'Medium';
      selectedDueDate = task['dueDate'] != null ? DateTime.parse(task['dueDate']) : null;
    });

    _openAddEditSheet(isEdit: true);
  }

  void toggleCompleted(String id, bool value) {
    final idx = tasks.indexWhere((t) => t['id'] == id);
    if (idx >= 0) {
      setState(() {
        tasks[idx]['completed'] = value;
      });
      _savePrefs();
    }
  }

  void deleteTaskAt(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _savePrefs();
  }

  // ---------- UI: Add/Edit Bottom Sheet ----------
  void _openAddEditSheet({bool isEdit = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Wrap(
            children: [
              ListTile(
                title: Text(isEdit ? 'Edit Task' : 'Add Task', style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _taskController.clear();
                    selectedDueDate = null;
                    Navigator.of(context).pop();
                  },
                ),
              ),
              TextField(
                controller: _taskController,
                decoration: const InputDecoration(labelText: 'Task title', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              // category + priority row
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => setState(() => selectedCategory = v ?? categories.first),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedPriority,
                      decoration: const InputDecoration(labelText: 'Priority'),
                      items: priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                      onChanged: (v) => setState(() => selectedPriority = v ?? 'Medium'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(selectedDueDate == null ? 'No due date' : 'Due: ${selectedDueDate!.toLocal().toString().split(' ')[0]}'),
                  ),
                  TextButton(
                    onPressed: _pickDueDate,
                    child: const Text('Pick Due Date'),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isEdit ? editTaskSave : addTaskFromInput,
                      child: Text(isEdit ? 'Save' : 'Add Task'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDueDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() => selectedDueDate = picked);
    }
  }

  // ---------- Filtering / Search ----------
  List<Map<String, dynamic>> _filteredTasks() {
    final q = _searchController.text.trim().toLowerCase();
    return tasks.where((t) {
      if (!showCompleted && (t['completed'] == true)) return false;
      if (q.isEmpty) return true;
      final title = (t['title'] ?? '').toString().toLowerCase();
      final cat = (t['category'] ?? '').toString().toLowerCase();
      final priority = (t['priority'] ?? '').toString().toLowerCase();
      return title.contains(q) || cat.contains(q) || priority.contains(q);
    }).toList();
  }

  // ---------- Build ----------
  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTasks();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(useMaterial3: false, brightness: Brightness.light, primarySwatch: Colors.blue),
      darkTheme: ThemeData(useMaterial3: false, brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced To-Do (Single StatefulWidget)'),
          actions: [
            IconButton(
              icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                });
                _savePrefs();
              },
              tooltip: 'Toggle theme',
            ),
            IconButton(
              icon: const Icon(Icons.check_box),
              onPressed: () => setState(() => showCompleted = !showCompleted),
              tooltip: showCompleted ? 'Hide completed' : 'Show completed',
            ),
            const SizedBox(width: 8),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search tasks, category, priority...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                ),
              ),
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: filtered.isEmpty
              ? Center(
            child: Text(
              tasks.isEmpty ? 'No tasks yet. Add your first task.' : 'No matching tasks.',
              style: const TextStyle(fontSize: 18),
            ),
          )
              : ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, idx) {
              final t = filtered[idx];
              // find original index to handle removal correctly
              final originalIndex = tasks.indexWhere((x) => x['id'] == t['id']);
              return Dismissible(
                key: Key(t['id']),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  setState(() {
                    if (originalIndex >= 0) tasks.removeAt(originalIndex);
                  });
                  _savePrefs();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task deleted')));
                },
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: t['completed'] ?? false,
                      onChanged: (v) {
                        toggleCompleted(t['id'], v ?? false);
                      },
                    ),
                    title: Text(
                      t['title'] ?? '',
                      style: TextStyle(
                        decoration: (t['completed'] == true) ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category: ${t['category'] ?? ''} • Priority: ${t['priority'] ?? ''}'),
                        if (t['dueDate'] != null) Text('Due: ${DateTime.parse(t['dueDate']).toLocal().toString().split(' ')[0]}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => startEditTask(t),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // reset add-edit state
            isEditing = false;
            editingId = '';
            _taskController.clear();
            selectedCategory = categories.first;
            selectedPriority = 'Medium';
            selectedDueDate = null;
            _openAddEditSheet(isEdit: false);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _taskController.dispose();
    super.dispose();
  }
}



//4
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // --------------------- TASK MODEL ---------------------
// class Task {
//   String id;
//   String title;
//   String notes;
//   String category;
//   String priority;
//   DateTime? dueDate;
//   bool completed;
//   DateTime createdAt;
//
//   Task({
//     required this.id,
//     required this.title,
//     this.notes = '',
//     required this.category,
//     required this.priority,
//     this.dueDate,
//     this.completed = false,
//     DateTime? createdAt,
//   }) : createdAt = createdAt ?? DateTime.now();
//
//   factory Task.fromMap(Map<String, dynamic> m) {
//     return Task(
//       id: m['id'],
//       title: m['title'],
//       notes: m['notes'] ?? '',
//       category: m['category'] ?? 'Work',
//       priority: m['priority'] ?? 'Medium',
//       dueDate: m['dueDate'] != null ? DateTime.parse(m['dueDate']) : null,
//       completed: m['completed'] ?? false,
//       createdAt: m['createdAt'] != null ? DateTime.parse(m['createdAt']) : DateTime.now(),
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'notes': notes,
//       'category': category,
//       'priority': priority,
//       'dueDate': dueDate?.toIso8601String(),
//       'completed': completed,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }
//
// // --------------------- TODO PROVIDER (simple) ---------------------
// class TodoProvider extends ChangeNotifier {
//   List<Task> _tasks = [];
//   ThemeMode _theme = ThemeMode.light;
//
//   List<String> categories = ['Work', 'Personal', 'Shopping'];
//   List<String> priorities = ['High', 'Medium', 'Low'];
//
//   static const String prefsKey = 'todo_tasks_v2';
//   static const String prefsThemeKey = 'todo_theme_v2';
//
//   List<Task> get tasks => _tasks;
//   ThemeMode get themeMode => _theme;
//
//   Future<void> loadFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final raw = prefs.getString(prefsKey);
//     final themeStr = prefs.getString(prefsThemeKey);
//
//     if (raw != null) {
//       final List<dynamic> decoded = jsonDecode(raw);
//       _tasks = decoded.map((e) => Task.fromMap(Map<String, dynamic>.from(e))).toList();
//     }
//
//     if (themeStr != null) {
//       _theme = themeStr == 'dark' ? ThemeMode.dark : ThemeMode.light;
//     }
//     notifyListeners();
//   }
//
//   Future<void> _saveToPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final encoded = jsonEncode(_tasks.map((t) => t.toMap()).toList());
//     await prefs.setString(prefsKey, encoded);
//     await prefs.setString(prefsThemeKey, _theme == ThemeMode.dark ? 'dark' : 'light');
//   }
//
//   void addTask(Task t) {
//     _tasks.insert(0, t);
//     _saveToPrefs();
//     notifyListeners();
//   }
//
//   void updateTask(Task t) {
//     final idx = _tasks.indexWhere((x) => x.id == t.id);
//     if (idx >= 0) {
//       _tasks[idx] = t;
//       _saveToPrefs();
//       notifyListeners();
//     }
//   }
//
//   void removeTaskById(String id) {
//     _tasks.removeWhere((t) => t.id == id);
//     _saveToPrefs();
//     notifyListeners();
//   }
//
//   void toggleCompleted(String id, bool val) {
//     final idx = _tasks.indexWhere((t) => t.id == id);
//     if (idx >= 0) {
//       _tasks[idx].completed = val;
//       _saveToPrefs();
//       notifyListeners();
//     }
//   }
//
//   void toggleTheme() {
//     _theme = _theme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
//     _saveToPrefs();
//     notifyListeners();
//   }
// }
//
// // --------------------- TASK TILE WIDGET ---------------------
// class TaskTile extends StatelessWidget {
//   final Task task;
//   final void Function() onEdit;
//   final void Function() onDelete;
//   final void Function(bool?) onToggle;
//
//   const TaskTile({super.key, required this.task, required this.onEdit, required this.onDelete, required this.onToggle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: Key(task.id),
//       direction: DismissDirection.endToStart,
//       onDismissed: (_) => onDelete(),
//       background: Container(
//         color: Colors.red,
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: const Icon(Icons.delete, color: Colors.white),
//       ),
//       child: Card(
//         child: ListTile(
//           leading: Checkbox(value: task.completed, onChanged: onToggle),
//           title: Text(task.title, style: TextStyle(decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none)),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('${task.category} • ${task.priority}'),
//               if (task.dueDate != null) Text('Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}'),
//             ],
//           ),
//           trailing: IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
//         ),
//       ),
//     );
//   }
// }
//
// // --------------------- MAIN APP (uses TodoProvider) ---------------------
// void main() {
//   runApp(const ModularTodoApp());
// }
//
// class ModularTodoApp extends StatefulWidget {
//   const ModularTodoApp({super.key});
//
//   @override
//   State<ModularTodoApp> createState() => _ModularTodoAppState();
// }
//
// class _ModularTodoAppState extends State<ModularTodoApp> {
//   final TodoProvider provider = TodoProvider();
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     provider.loadFromPrefs();
//     provider.addListener(() => setState(() {}));
//   }
//
//   @override
//   void dispose() {
//     provider.removeListener(() {});
//     searchController.dispose();
//     super.dispose();
//   }
//
//   List<Task> filteredTasks() {
//     final q = searchController.text.trim().toLowerCase();
//     return provider.tasks.where((t) {
//       if (q.isEmpty) return true;
//       return t.title.toLowerCase().contains(q) ||
//           t.category.toLowerCase().contains(q) ||
//           t.priority.toLowerCase().contains(q);
//     }).toList();
//   }
//
//   // Helper to show add/edit dialog
//   Future<void> showAddEditDialog({Task? editing}) async {
//     final titleController = TextEditingController(text: editing?.title ?? '');
//     String category = editing?.category ?? provider.categories.first;
//     String priority = editing?.priority ?? 'Medium';
//     DateTime? due = editing?.dueDate;
//
//     await showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(editing == null ? 'Add Task' : 'Edit Task'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: category,
//                 decoration: const InputDecoration(labelText: 'Category'),
//                 items: provider.categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//                 onChanged: (v) => category = v ?? category,
//               ),
//               const SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: priority,
//                 decoration: const InputDecoration(labelText: 'Priority'),
//                 items: provider.priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
//                 onChanged: (v) => priority = v ?? priority,
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(child: Text(due == null ? 'No due date' : 'Due: ${due?.toLocal().toString().split(' ')[0]}')),
//                   TextButton(
//                     onPressed: () async {
//                       final now = DateTime.now();
//                       final picked = await showDatePicker(context: context, initialDate: due ?? now, firstDate: DateTime(now.year - 2), lastDate: DateTime(now.year + 5));
//                       if (picked != null) due = picked;
//                       setState(() {});
//                     },
//                     child: const Text('Pick Date'),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
//           ElevatedButton(
//             onPressed: () {
//               final title = titleController.text.trim();
//               if (title.isEmpty) return;
//               if (editing == null) {
//                 final t = Task(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, category: category, priority: priority, dueDate: due);
//                 provider.addTask(t);
//               } else {
//                 final t = Task(id: editing.id, title: title, category: category, priority: priority, dueDate: due, completed: editing.completed, createdAt: editing.createdAt);
//                 provider.updateTask(t);
//               }
//               Navigator.pop(context);
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final list = filteredTasks();
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: provider.themeMode,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Modular To-Do App'),
//           actions: [
//             IconButton(
//               icon: Icon(provider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
//               onPressed: provider.toggleTheme,
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(56),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: searchController,
//                 onChanged: (_) => setState(() {}),
//                 decoration: InputDecoration(
//                   hintText: 'Search tasks, category, priority...',
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: searchController.text.isEmpty
//                       ? null
//                       : IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: () {
//                       searchController.clear();
//                       setState(() {});
//                     },
//                   ),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: list.isEmpty
//             ? Center(child: Text(provider.tasks.isEmpty ? 'No tasks yet.' : 'No matches.'))
//             : ListView.builder(
//           padding: const EdgeInsets.all(8),
//           itemCount: list.length,
//           itemBuilder: (context, idx) {
//             final t = list[idx];
//             return TaskTile(
//               task: t,
//               onDelete: () => provider.removeTaskById(t.id),
//               onEdit: () => showAddEditDialog(editing: t),
//               onToggle: (v) => provider.toggleCompleted(t.id, v ?? false),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => showAddEditDialog(),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }



// kp code tops
// import 'package:flutter/material.dart';
//
// class Task_25_to_28 extends StatefulWidget {
//   const Task_25_to_28({Key? key}) : super(key: key);
//
//   @override
//   State<Task_25_to_28> createState() => _Task_25_to_28State();
// }
//
// class _Task_25_to_28State extends State<Task_25_to_28> {
//   final TextEditingController _taskCtrl = TextEditingController();
//   final List<Map<String, dynamic>> _tasks = [];
//   final ScrollController _scrollCtrl = ScrollController();
//   int _nextItem = 1;
//
//   final List<Map<String, dynamic>> _products = [
//     {
//       'name': 'Sneakers',
//       'price': 59.99,
//       'img': 'https://picsum.photos/200?image=10',
//       'color': Color(0xFFFAE1DD),
//     },
//     {
//       'name': 'Wrist Watch',
//       'price': 120.00,
//       'img': 'https://picsum.photos/200?image=20',
//       'color': Color(0xFFD8E2DC),
//     },
//     {
//       'name': 'Headphones',
//       'price': 45.50,
//       'img': 'https://picsum.photos/200?image=30',
//       'color': Color(0xFFFFE5EC),
//     },
//     {
//       'name': 'Camera',
//       'price': 200.00,
//       'img': 'https://picsum.photos/200?image=40',
//       'color': Color(0xFFBEE1E6),
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollCtrl.addListener(() {
//       if (_scrollCtrl.position.pixels ==
//           _scrollCtrl.position.maxScrollExtent) {
//         _loadMoreItems();
//       }
//     });
//   }
//
//   void _loadMoreItems() {
//     setState(() {
//       for (int i = 0; i < 5; i++) {
//         _tasks.add({
//           'title': 'Auto-generated Task ${_nextItem++}',
//           'done': false,
//         });
//       }
//     });
//   }
//
//   void _addTask() {
//     if (_taskCtrl.text.trim().isEmpty) return;
//     setState(() {
//       _tasks.insert(0, {'title': _taskCtrl.text.trim(), 'done': false});
//       _taskCtrl.clear();
//     });
//   }
//
//   void _toggleTask(int index, bool? value) {
//     setState(() {
//       _tasks[index]['done'] = value ?? false;
//     });
//   }
//
//   void _removeTask(int index) {
//     setState(() {
//       _tasks.removeAt(index);
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollCtrl.dispose();
//     _taskCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8EDEB), // light pastel pink background
//       appBar: AppBar(
//         title: const Text('Smart Task & Product Manager'),
//         backgroundColor: const Color(0xFFBEE1E6), // soft blue pastel
//         foregroundColor: Colors.black87,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           controller: _scrollCtrl,
//           children: [
//             const Text(
//               'Recommended Products',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF5B5B5B),
//               ),
//             ),
//             const SizedBox(height: 10),
//
//             SizedBox(
//               height: 250,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _products.length,
//                 itemBuilder: (context, index) {
//                   final p = _products[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: 160,
//                       margin: const EdgeInsets.only(right: 12),
//                       decoration: BoxDecoration(
//                         color: p['color'],
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                             offset: const Offset(2, 2),
//                           )
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.network(
//                                 p['img'],
//                                 height: 100,
//                                 width: 100,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               p['name'],
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF333333),
//                               ),
//                             ),
//                             Text(
//                               '\₹${p['price']}',
//                               style: const TextStyle(color: Colors.black54),
//                             ),
//                             const SizedBox(height: 6),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFBEE1E6),
//                                 foregroundColor: Colors.black,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 8),
//                               ),
//                               onPressed: () {},
//                               child: const Text('Buy'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 25),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFE5EC),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _taskCtrl,
//                       decoration: const InputDecoration(
//                         hintText: 'Add a new task...',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFD8E2DC),
//                       foregroundColor: Colors.black,
//                     ),
//                     onPressed: _addTask,
//                     child: const Text('Add'),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Task List (swipe, checkbox, auto-load)
//             ..._tasks.map((task) {
//               int index = _tasks.indexOf(task);
//               return Dismissible(
//                 key: Key(task['title']),
//                 onDismissed: (_) => _removeTask(index),
//                 background: Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFFEC5BB),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(vertical: 4),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFD8E2DC),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: CheckboxListTile(
//                     activeColor: const Color(0xFFBEE1E6),
//                     value: task['done'],
//                     onChanged: (v) => _toggleTask(index, v),
//                     title: Text(
//                       task['title'],
//                       style: TextStyle(
//                         fontSize: 16,
//                         decoration: task['done']
//                             ? TextDecoration.lineThrough
//                             : TextDecoration.none,
//                       ),
//                     ),
//                     secondary:
//                     const Icon(Icons.task_alt, color: Color(0xFFB392AC)),
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }