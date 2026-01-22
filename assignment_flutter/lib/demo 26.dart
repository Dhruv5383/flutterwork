// import 'package:flutter/material.dart';
//
// class InfiniteListApi extends StatefulWidget {
//   const InfiniteListApi({super.key});
//
//   @override
//   State<InfiniteListApi> createState() => _InfiniteListApiState();
// }
//
// class _InfiniteListApiState extends State<InfiniteListApi> {
//   final ScrollController _scrollController = ScrollController();
//   final List<String> items = [];
//
//   bool isLoading = false;
//   int page = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent &&
//           !isLoading) {
//         fetchData();
//       }
//     });
//   }
//
//   Future<void> fetchData() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     // Simulate API delay
//     await Future.delayed(const Duration(seconds: 2));
//
//     List<String> newData = List.generate(
//       10,
//           (index) => "Page $page - Item ${index + 1}",
//     );
//
//     setState(() {
//       page++;
//       items.addAll(newData);
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Infinite Scroll API")),
//       body: ListView.builder(
//         controller: _scrollController,
//         itemCount: items.length + (isLoading ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == items.length) {
//             return const Padding(
//               padding: EdgeInsets.all(16),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//           return ListTile(
//             title: Text(items[index]),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// class InfiniteApiList extends StatefulWidget {
//   const InfiniteApiList({super.key});
//
//   @override
//   State<InfiniteApiList> createState() => _InfiniteApiListState();
// }
//
// class _InfiniteApiListState extends State<InfiniteApiList> {
//   final ScrollController _controller = ScrollController();
//   final List<dynamic> posts = [];
//
//   int page = 1;
//   final int limit = 10;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPosts();
//
//     _controller.addListener(() {
//       if (_controller.position.pixels ==
//           _controller.position.maxScrollExtent &&
//           !isLoading) {
//         fetchPosts();
//       }
//     });
//   }
//
//   Future<void> fetchPosts() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     final url = Uri.parse(
//         'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit');
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final List data = jsonDecode(response.body);
//
//       setState(() {
//         page++;
//         posts.addAll(data);
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Infinite API Scroll")),
//       body: ListView.builder(
//         controller: _controller,
//         itemCount: posts.length + (isLoading ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == posts.length) {
//             return const Padding(
//               padding: EdgeInsets.all(16),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }
//
//           return ListTile(
//             title: Text(posts[index]['title']),
//             subtitle: Text(posts[index]['body']),
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class RefreshInfiniteList extends StatefulWidget {
//   const RefreshInfiniteList({super.key});
//
//   @override
//   State<RefreshInfiniteList> createState() => _RefreshInfiniteListState();
// }
//
// class _RefreshInfiniteListState extends State<RefreshInfiniteList> {
//   final ScrollController _controller = ScrollController();
//   final List<dynamic> posts = [];
//
//   int page = 1;
//   final int limit = 10;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPosts();
//
//     _controller.addListener(() {
//       if (_controller.position.pixels ==
//           _controller.position.maxScrollExtent &&
//           !isLoading) {
//         fetchPosts();
//       }
//     });
//   }
//
//   Future<void> fetchPosts() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     final url = Uri.parse(
//         'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit');
//
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final List data = jsonDecode(response.body);
//
//       setState(() {
//         page++;
//         posts.addAll(data);
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> refreshData() async {
//     setState(() {
//       page = 1;
//       posts.clear();
//     });
//     await fetchPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pull to Refresh + Infinite")),
//       body: RefreshIndicator(
//         onRefresh: refreshData,
//         child: ListView.builder(
//           controller: _controller,
//           itemCount: posts.length + (isLoading ? 1 : 0),
//           itemBuilder: (context, index) {
//             if (index == posts.length) {
//               return const Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             }
//
//             return ListTile(
//               title: Text(posts[index]['title']),
//               subtitle: Text(posts[index]['body']),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }





import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InfiniteStopList extends StatefulWidget {
  const InfiniteStopList({super.key});

  @override
  State<InfiniteStopList> createState() => _InfiniteStopListState();
}

class _InfiniteStopListState extends State<InfiniteStopList> {
  final ScrollController _controller = ScrollController();
  final List<dynamic> posts = [];

  int page = 1;
  final int limit = 10;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();

    _controller.addListener(() {
      if (_controller.position.pixels ==
          _controller.position.maxScrollExtent &&
          !isLoading &&
          hasMore) {
        fetchPosts();
      }
    });
  }

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      setState(() {
        if (data.isEmpty) {
          hasMore = false;
        } else {
          page++;
          posts.addAll(data);
        }
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Infinite Scroll (Stop)")),
      body: ListView.builder(
        controller: _controller,
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index < posts.length) {
            return ListTile(
              title: Text(posts[index]['title']),
              subtitle: Text(posts[index]['body']),
            );
          }

          // Bottom widget
          if (isLoading) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (!hasMore) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: Text("No more data")),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
