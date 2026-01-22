// import 'package:flutter/material.dart';
//
// class CustomListPage extends StatefulWidget {
//   const CustomListPage({super.key});
//
//   @override
//   State<CustomListPage> createState() => _CustomListPageState();
// }
//
// class _CustomListPageState extends State<CustomListPage> {
//   List<String> items = [
//     "Apple",
//     "Banana",
//     "Orange",
//     "Mango",
//     "Grapes",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Custom ListTile"),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.blue,
//                 child: Text(
//                   items[index][0],
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//               title: Text(
//                 items[index],
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: const Text("Tap delete to remove"),
//               trailing: IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: () {
//                   setState(() {
//                     items.removeAt(index);
//                   });
//                 },
//               ),
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("${items[index]} tapped")),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
//
// class CustomListPage extends StatefulWidget {
//   const CustomListPage({super.key});
//
//   @override
//   State<CustomListPage> createState() => _CustomListPageState();
// }
//
// class _CustomListPageState extends State<CustomListPage> {
//   List<Map<String, dynamic>> items = [
//     {"title": "Music", "icon": Icons.music_note},
//     {"title": "Camera", "icon": Icons.camera_alt},
//     {"title": "Shopping", "icon": Icons.shopping_cart},
//     {"title": "Travel", "icon": Icons.flight},
//     {"title": "Food", "icon": Icons.fastfood},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Custom Styled List"),
//         backgroundColor: Colors.grey[900],
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Dismissible(
//             key: Key(items[index]["title"]),
//             direction: DismissDirection.endToStart,
//             background: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.only(right: 20),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(Icons.delete, color: Colors.white),
//             ),
//             onDismissed: (direction) {
//               setState(() {
//                 items.removeAt(index);
//               });
//             },
//             child: Card(
//               color: Colors.grey[900],
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.blue,
//                   child: Icon(
//                     items[index]["icon"],
//                     color: Colors.white,
//                   ),
//                 ),
//                 title: Text(
//                   items[index]["title"],
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 subtitle: const Text(
//                   "Swipe or tap delete",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       items.removeAt(index);
//                     });
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
//
// class CustomListPage extends StatefulWidget {
//   const CustomListPage({super.key});
//
//   @override
//   State<CustomListPage> createState() => _CustomListPageState();
// }
//
// class _CustomListPageState extends State<CustomListPage> {
//   List<Map<String, dynamic>> items = [
//     {"title": "Music", "icon": Icons.music_note},
//     {"title": "Camera", "icon": Icons.camera_alt},
//     {"title": "Shopping", "icon": Icons.shopping_cart},
//     {"title": "Travel", "icon": Icons.flight},
//     {"title": "Food", "icon": Icons.fastfood},
//   ];
//
//   Map<String, dynamic>? lastRemovedItem;
//   int? lastRemovedIndex;
//
//   void deleteItem(int index) {
//     setState(() {
//       lastRemovedItem = items[index];
//       lastRemovedIndex = index;
//       items.removeAt(index);
//     });
//
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text("Item deleted"),
//         action: SnackBarAction(
//           label: "UNDO",
//           onPressed: () {
//             setState(() {
//               items.insert(lastRemovedIndex!, lastRemovedItem!);
//             });
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Undo Delete List"),
//         backgroundColor: Colors.grey[900],
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Dismissible(
//             key: Key(items[index]["title"]),
//             direction: DismissDirection.endToStart,
//             background: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               padding: const EdgeInsets.only(right: 20),
//               alignment: Alignment.centerRight,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(Icons.delete, color: Colors.white),
//             ),
//             onDismissed: (_) => deleteItem(index),
//             child: Card(
//               color: Colors.grey[900],
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.blue,
//                   child: Icon(
//                     items[index]["icon"],
//                     color: Colors.white,
//                   ),
//                 ),
//                 title: Text(
//                   items[index]["title"],
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 subtitle: const Text(
//                   "Swipe or tap delete",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () => deleteItem(index),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// final code
import 'package:flutter/material.dart';

class AdvancedGridPage extends StatefulWidget {
  const AdvancedGridPage({super.key});

  @override
  State<AdvancedGridPage> createState() => _AdvancedGridPageState();
}

class _AdvancedGridPageState extends State<AdvancedGridPage> {
  List<Map<String, dynamic>> allItems = [
    {"title": "Music", "icon": Icons.music_note},
    {"title": "Camera", "icon": Icons.camera_alt},
    {"title": "Shopping", "icon": Icons.shopping_cart},
    {"title": "Travel", "icon": Icons.flight},
    {"title": "Food", "icon": Icons.fastfood},
    {"title": "Games", "icon": Icons.games},
    {"title": "Books", "icon": Icons.book},
  ];

  List<Map<String, dynamic>> visibleItems = [];

  Map<String, dynamic>? lastRemovedItem;
  int? lastRemovedIndex;

  @override
  void initState() {
    super.initState();
    visibleItems = List.from(allItems);
  }

  void deleteItem(int index) {
    setState(() {
      lastRemovedItem = visibleItems[index];
      lastRemovedIndex = allItems.indexOf(visibleItems[index]);
      allItems.removeAt(lastRemovedIndex!);
      visibleItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Item deleted"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              allItems.insert(lastRemovedIndex!, lastRemovedItem!);
              visibleItems = List.from(allItems);
            });
          },
        ),
      ),
    );
  }

  void searchItem(String query) {
    setState(() {
      visibleItems = allItems
          .where((item) =>
          item["title"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showMenu(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                deleteItem(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.blue),
              title: const Text("Details",
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                    Text("${visibleItems[index]["title"]} selected"),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Advanced Grid List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: searchItem,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🧩 GridView
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: visibleItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => showMenu(context, index),
                  child: Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            visibleItems[index]["icon"],
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          visibleItems[index]["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteItem(index),
                        ),
                      ],
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
