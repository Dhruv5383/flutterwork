// import 'package:flutter/material.dart';
//
//
// class InfiniteList extends StatefulWidget {
//   const InfiniteList({super.key});
//
//   @override
//   State<InfiniteList> createState() => _InfiniteListState();
// }
//
// class _InfiniteListState extends State<InfiniteList> {
//   final List<int> items = [];
//   bool isLoading = false;
//   int page = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     loadMore();
//   }
//
//   void loadMore() async {
//     if (isLoading) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     // Simulate network delay
//     await Future.delayed(const Duration(seconds: 2));
//
//     List<int> newItems = List.generate(20, (index) => page * 20 + index);
//
//     setState(() {
//       items.addAll(newItems);
//       page++;
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Infinite Scroll")),
//       body: ListView.builder(
//         itemCount: items.length + 1,
//         itemBuilder: (context, index) {
//           if (index == items.length) {
//             loadMore();
//             return const Padding(
//               padding: EdgeInsets.all(16),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//           return ListTile(title: Text("Item ${items[index]}"));
//         },
//       ),
//     );
//   }
// }
//

// import 'package:flutter/material.dart';
//
// class InfiniteScrollList extends StatefulWidget {
//   @override
//   _InfiniteScrollListState createState() => _InfiniteScrollListState();
// }
//
// class _InfiniteScrollListState extends State<InfiniteScrollList> {
//   final List<int> _items = List.generate(20, (i) => i); // Initial data
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // 1. Add listener to the controller
//     _scrollController.addListener(() {
//       // Check if user has scrolled to the bottom (within 200 pixels)
//       if (_scrollController.position.pixels >=
//           _scrollController.position.maxScrollExtent - 200) {
//         _loadMoreData();
//       }
//     });
//   }
//
//   Future<void> _loadMoreData() async {
//     if (_isLoading) return; // Prevent duplicate calls
//
//     setState(() => _isLoading = true);
//
//     // Simulate network delay
//     await Future.delayed(Duration(seconds: 2));
//
//     setState(() {
//       // Generate 20 more items
//       _items.addAll(List.generate(20, (i) => _items.length + i));
//       _isLoading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose(); // Always dispose controllers
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Infinite Scroll")),
//       body: ListView.builder(
//         controller: _scrollController, // 2. Attach the controller
//         itemCount: _items.length + (_isLoading ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index < _items.length) {
//             return ListTile(
//               title: Text("Item ${_items[index]}"),
//               leading: CircleAvatar(child: Text("${_items[index]}")),
//             );
//           } else {
//             // 3. Show a loading spinner at the bottom
//             return Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//
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





import 'dart:convert';
import 'package:assignment_flutter/task26_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiInfiniteScroll extends StatefulWidget {
  @override
  _ApiInfiniteScrollState createState() => _ApiInfiniteScrollState();
}

class _ApiInfiniteScrollState extends State<ApiInfiniteScroll> {
  final ScrollController _scrollController = ScrollController();
  final List<Post> _posts = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true; // Stop calling API if no more data is available

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Initial load
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _fetchPosts();
      }
    });
  }

  Future<void> _fetchPosts() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    // Replace with your real paginated API endpoint
    final url = 'https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=15';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List newItems = json.decode(response.body);

        setState(() {
          _page++;
          _isLoading = false;
          // If the API returns fewer items than the limit, we've reached the end
          if (newItems.length < 15) {
            _hasMore = false;
          }
          _posts.addAll(newItems.map((item) => Post.fromJson(item)).toList());
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      // Handle errors here (e.g., show a SnackBar)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Pagination")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _posts.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _posts.length) {
            return ListTile(
              title: Text(_posts[index].title),
              subtitle: Text("Post ID: ${_posts[index].id}"),
            );
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}