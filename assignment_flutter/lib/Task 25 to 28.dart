// import 'package:flutter/material.dart';
//
// class TodoProductApp extends StatefulWidget {
//   const TodoProductApp({super.key});
//
//   @override
//   State<TodoProductApp> createState() => _TodoProductAppState();
// }
//
// class _TodoProductAppState extends State<TodoProductApp> {
//   // ---------- TODO ----------
//   final TextEditingController controller = TextEditingController();
//   List<String> tasks = List.generate(10, (i) => "Task ${i + 1}");
//   bool isLoading = false;
//
//   // ---------- PRODUCTS ----------
//   final List<Map<String, dynamic>> products = [
//     {
//       'name': 'Shoes',
//       'price': '₹2,499',
//       'image': 'assets/images/shoes.jpg'
//     },
//     {
//       'name': 'Watch',
//       'price': '₹1,999',
//       'image': 'assets/images/watch.jpg'
//     },
//     {
//       'name': 'Bag',
//       'price': '₹1,299',
//       'image': 'assets/images/bag.jpg'
//     },
//     {
//       'name': 'Headphones',
//       'price': '₹3,499',
//       'image': 'assets/images/headphones.jpg'
//     },
//   ];
//
//   // ---------- LOAD MORE ----------
//   void loadMore() async {
//     if (isLoading) return;
//
//     setState(() => isLoading = true);
//
//     await Future.delayed(const Duration(seconds: 2));
//
//     setState(() {
//       tasks.addAll(
//         List.generate(5, (i) => "Loaded Task ${tasks.length + i + 1}"),
//       );
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("To-Do & Product List")),
//
//       body: Column(
//         children: [
//
//           // ---------- ADD TASK ----------
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: controller,
//                     decoration:
//                     const InputDecoration(hintText: "Enter task"),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     if (controller.text.isNotEmpty) {
//                       setState(() {
//                         tasks.insert(0, controller.text);
//                         controller.clear();
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // ---------- PRODUCT LIST (HORIZONTAL) ----------
//           SizedBox(
//             height: 150,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return Container(
//                   width: 140,
//                   margin: const EdgeInsets.all(8),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Image.asset(product["image"]),
//                       ),
//                       Text(
//                         product["name"],
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text("₹${product["price"]}"),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // ---------- TODO LIST (INFINITE + SWIPE DELETE) ----------
//           Expanded(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (scroll) {
//                 if (scroll.metrics.pixels ==
//                     scroll.metrics.maxScrollExtent) {
//                   loadMore();
//                 }
//                 return false;
//               },
//               child: ListView.builder(
//                 itemCount: tasks.length + (isLoading ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index == tasks.length) {
//                     return const Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   }
//
//                   return Dismissible(
//                     key: ValueKey(tasks[index]),
//                     onDismissed: (_) {
//                       setState(() => tasks.removeAt(index));
//                     },
//                     child: ListTile(
//                       leading: const Icon(Icons.task_alt),
//                       title: Text(tasks[index]),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () {
//                           setState(() => tasks.removeAt(index));
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





// A

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // ------------------ APP ROOT ------------------
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Todo Pro',
// //       theme: ThemeData(
// //         primarySwatch: Colors.indigo,
// //       ),
// //       home: const HomePage(),
// //     );
// //   }
// // }
//
// // ------------------ HOME PAGE ------------------
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<String> tasks = [];
//   List<String> filteredTasks = [];
//   final TextEditingController searchCtrl = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     loadTasks();
//   }
//
//   // ---------- LOAD FROM STORAGE ----------
//   Future<void> loadTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       tasks = prefs.getStringList('tasks') ?? [];
//       filteredTasks = tasks;
//     });
//   }
//
//   // ---------- SAVE ----------
//   Future<void> saveTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('tasks', tasks);
//   }
//
//   // ---------- SEARCH ----------
//   void search(String query) {
//     setState(() {
//       filteredTasks = tasks
//           .where((t) => t.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   // ---------- DELETE ----------
//   void deleteTask(int index) {
//     setState(() {
//       tasks.remove(filteredTasks[index]);
//       filteredTasks = tasks;
//     });
//     saveTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Todo Pro"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () async {
//               final result = await Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const AddTaskPage()),
//               );
//               if (result != null) {
//                 setState(() {
//                   tasks.add(result);
//                   filteredTasks = tasks;
//                 });
//                 saveTasks();
//               }
//             },
//           )
//         ],
//       ),
//
//       body: Column(
//         children: [
//
//           // ---------- SEARCH ----------
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: TextField(
//               controller: searchCtrl,
//               onChanged: search,
//               decoration: InputDecoration(
//                 hintText: "Search task...",
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//
//           // ---------- GRID VIEW ----------
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(10),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 3 / 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: filteredTasks.length,
//               itemBuilder: (context, index) {
//                 return Dismissible(
//                   key: ValueKey(filteredTasks[index]),
//                   onDismissed: (_) => deleteTask(index),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.indigo.shade100,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: ListTile(
//                       title: Text(
//                         filteredTasks[index],
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () => deleteTask(index),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ------------------ ADD TASK PAGE ------------------
// class AddTaskPage extends StatefulWidget {
//   const AddTaskPage({super.key});
//
//   @override
//   State<AddTaskPage> createState() => _AddTaskPageState();
// }
//
// class _AddTaskPageState extends State<AddTaskPage> {
//   final TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Task")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: controller,
//               decoration: const InputDecoration(
//                 hintText: "Enter task name",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (controller.text.isNotEmpty) {
//                   Navigator.pop(context, controller.text);
//                 }
//               },
//               child: const Text("Save"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }






// B
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ForcedScaffoldApp extends StatefulWidget {
//   const ForcedScaffoldApp({super.key});
//
//   @override
//   State<ForcedScaffoldApp> createState() => _ForcedScaffoldAppState();
// }
//
// class _ForcedScaffoldAppState extends State<ForcedScaffoldApp> {
//   final TextEditingController taskCtrl = TextEditingController();
//   final TextEditingController searchCtrl = TextEditingController();
//
//   List<String> tasks = [];
//   List<String> filteredTasks = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadTasks();
//   }
//
//   // ---------- STORAGE ----------
//   Future<void> loadTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       tasks = prefs.getStringList('tasks') ?? [];
//       filteredTasks = tasks;
//     });
//   }
//
//   Future<void> saveTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('tasks', tasks);
//   }
//
//   // ---------- SEARCH ----------
//   void searchTask(String value) {
//     setState(() {
//       filteredTasks = tasks
//           .where((t) => t.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }
//
//   // ---------- ADD ----------
//   void addTask() {
//     if (taskCtrl.text.isNotEmpty) {
//       setState(() {
//         tasks.insert(0, taskCtrl.text);
//         filteredTasks = tasks;
//         taskCtrl.clear();
//       });
//       saveTasks();
//     }
//   }
//
//   // ---------- DELETE ----------
//   void deleteTask(int index) {
//     setState(() {
//       tasks.remove(filteredTasks[index]);
//       filteredTasks = tasks;
//     });
//     saveTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text("Forced Scaffold App"),
//         backgroundColor: Colors.indigo,
//       ),
//
//       body: Column(
//         children: [
//
//           // ---------- ADD TASK ----------
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: taskCtrl,
//                     decoration: InputDecoration(
//                       hintText: "Add task",
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   icon: const Icon(Icons.add_circle, size: 32),
//                   color: Colors.indigo,
//                   onPressed: addTask,
//                 ),
//               ],
//             ),
//           ),
//
//           // ---------- SEARCH ----------
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextField(
//               controller: searchCtrl,
//               onChanged: searchTask,
//               decoration: InputDecoration(
//                 hintText: "Search task",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 10),
//
//           // ---------- GRID VIEW ----------
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(10),
//               gridDelegate:
//               const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 3 / 2,
//               ),
//               itemCount: filteredTasks.length,
//               itemBuilder: (context, index) {
//                 return Dismissible(
//                   key: ValueKey(filteredTasks[index]),
//                   onDismissed: (_) => deleteTask(index),
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: const [
//                         BoxShadow(
//                           blurRadius: 4,
//                           color: Colors.black12,
//                         )
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           filteredTasks[index],
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () => deleteTask(index),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }







//
// import 'package:flutter/material.dart';
//
// class ComprehensiveListApp extends StatefulWidget {
//   @override
//   _ComprehensiveListAppState createState() => _ComprehensiveListAppState();
// }
//
// class _ComprehensiveListAppState extends State<ComprehensiveListApp> {
//   // To-Do List State
//   final List<String> _tasks = List.generate(15, (i) => "Task ${i + 1}");
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _taskController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Infinite Scroll Logic
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
//         _loadMoreTasks();
//       }
//     });
//   }
//
//   void _loadMoreTasks() async {
//     if (_isLoading) return;
//     setState(() => _isLoading = true);
//
//     await Future.delayed(Duration(seconds: 1)); // Simulate API delay
//
//     setState(() {
//       _tasks.addAll(List.generate(10, (i) => "Extra Task ${_tasks.length + i + 1}"));
//       _isLoading = false;
//     });
//   }
//
//   void _addTask(String title) {
//     if (title.isNotEmpty) {
//       setState(() => _tasks.insert(0, title));
//       _taskController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Shopping & Tasks"), backgroundColor: Colors.indigo),
//       body: Column(
//         children: [
//           // 1. Horizontal Product Listing
//           _buildProductList(),
//
//           Divider(height: 1, thickness: 2),
//
//           // 2. Add Task Input
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _taskController,
//               decoration: InputDecoration(
//                 hintText: "Enter new task...",
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.add_circle),
//                   onPressed: () => _addTask(_taskController.text),
//                 ),
//               ),
//             ),
//           ),
//
//           // 3. Infinite Scroll To-Do List with Swipe-to-Dismiss
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: _tasks.length + (_isLoading ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index < _tasks.length) {
//                   final task = _tasks[index];
//                   return Dismissible(
//                     key: Key(task + index.toString()),
//                     direction: DismissDirection.endToStart,
//                     onDismissed: (direction) {
//                       setState(() => _tasks.removeAt(index));
//                     },
//                     background: Container(
//                       color: Colors.red,
//                       alignment: Alignment.centerRight,
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Icon(Icons.delete, color: Colors.white),
//                     ),
//                     child: ListTile(
//                       leading: Icon(Icons.check_circle_outline, color: Colors.indigo),
//                       title: Text(task),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete_outline, color: Colors.grey),
//                         onPressed: () => setState(() => _tasks.removeAt(index)),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Center(child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()));
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Horizontal Product Slider Helper
//   Widget _buildProductList() {
//     return Container(
//       height: 180,
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Container(
//             width: 140,
//             margin: EdgeInsets.symmetric(horizontal: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     'https://picsum.photos/200?random=$index',
//                     height: 100, width: 140, fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text("Product ${index + 1}", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text("\$${(index + 1) * 10}.99", style: TextStyle(color: Colors.green)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// final code
import 'package:flutter/material.dart';


class AdvancedListApp extends StatefulWidget {
  @override
  _AdvancedListAppState createState() => _AdvancedListAppState();
}

class _AdvancedListAppState extends State<AdvancedListApp> {
  // 1. Controller for Infinite Scroll
  final ScrollController _scrollController = ScrollController();

  // 2. Data Sources
  List<String> _todoItems = List.generate(15, (index) => "Task Item ${index + 1}");
  final List<Map<String, dynamic>> _products = List.generate(8, (index) => {
    "name": "Product ${index + 1}",
    "price": "\$${(index + 1) * 20}",
    "image": "https://via.placeholder.com/150/FF5733/FFFFFF?text=Prod+${index+1}"
  });

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 3. Attach Listener for Infinite Scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreData();
      }
    });
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _todoItems.addAll(List.generate(10, (index) => "New Task ${_todoItems.length + index + 1}"));
      _isLoading = false;
    });
  }

  void _addNewTask(String task) {
    setState(() {
      _todoItems.insert(0, task);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Advanced Lists")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Simple dialog to add task
          showDialog(
              context: context,
              builder: (context) {
                String newTask = "";
                return AlertDialog(
                  title: Text("Add Task"),
                  content: TextField(
                    onChanged: (val) => newTask = val,
                    decoration: InputDecoration(hintText: "Enter task name"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (newTask.isNotEmpty) _addNewTask(newTask);
                        Navigator.pop(context);
                      },
                      child: Text("ADD"),
                    )
                  ],
                );
              }
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- SECTION A: Horizontal Product List ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Featured Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 200, // Constrain height for horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Container(
                  width: 140,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(product['image'], fit: BoxFit.cover, width: double.infinity),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(product['price'], style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(thickness: 2),

          // --- SECTION B: Infinite Scroll To-Do List ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text("My Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded( // Take up remaining space
            child: ListView.builder(
              controller: _scrollController, // Infinite scroll controller
              itemCount: _todoItems.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _todoItems.length) {
                  return Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()));
                }

                final item = _todoItems[index];

                // Swipe to Remove
                return Dismissible(
                  key: Key(item), // Unique key for Dismissible
                  background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 20), child: Icon(Icons.delete, color: Colors.white)),
                  onDismissed: (direction) {
                    setState(() {
                      _todoItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.check, size: 20),
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      title: Text(item, style: TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: Text("Swipe to delete"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.grey),
                        onPressed: () {
                          // Manual delete button
                          setState(() {
                            _todoItems.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}