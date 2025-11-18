import 'package:flutter/material.dart';

class SearchApp extends StatefulWidget {
  const SearchApp({super.key});

  @override
  State<SearchApp> createState() => _SearchAppState();
}

class _SearchAppState extends State<SearchApp> {
  final TextEditingController searchController = TextEditingController();

  List<String> allItems = [
    "Apple",
    "Banana",
    "Mango",
    "Orange",
    "Pineapple",
    "Strawberry",
    "Watermelon",
    "Grapes",
    "Cherry"
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems); // show all initially
  }

  void filterList(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = List.from(allItems);
    } else {
      results = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Bar Example"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: filterList,
              decoration: const InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.label),
                    title: Text(filteredItems[index]),
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
