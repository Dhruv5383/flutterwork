import 'package:flutter/material.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final TextEditingController taskController = TextEditingController();

  // List of tasks (map with title + completed status)
  List<Map<String, dynamic>> tasks = [];

  void addTask() {
    String taskText = taskController.text.trim();
    if (taskText.isEmpty) return;

    setState(() {
      tasks.add({"title": taskText, "done": false});
    });

    taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Task Input Box
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Add Button
            ElevatedButton(
              onPressed: addTask,
              child: const Text("Add Task"),
            ),

            const SizedBox(height: 20),

            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(tasks[index]["title"]),
                    value: tasks[index]["done"],
                    onChanged: (value) {
                      setState(() {
                        tasks[index]["done"] = value!;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
