// import 'package:flutter/material.dart';
//
// class StackExamplesPage extends StatefulWidget {
//   @override
//   _StackExamplesPageState createState() => _StackExamplesPageState();
// }
//
// class _StackExamplesPageState extends State<StackExamplesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Stack Widget Examples")),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             /// 1️⃣ IMAGE WITH TRANSPARENT OVERLAY TEXT
//             Text("1. Image Overlay", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   height: 180,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage("https://picsum.photos/400"),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 Container(
//                   height: 180,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 Text(
//                   "Beautiful Overlay",
//                   style: TextStyle(color: Colors.white, fontSize: 22),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 30),
//
//             /// 2️⃣ PROFILE PAGE WITH CENTERED IMAGE
//             Text("2. Profile Stack", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.topCenter,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 50),
//                   padding: EdgeInsets.only(top: 60, bottom: 20),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       Text("Dhruv Patel", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       Text("Flutter Developer"),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   child: CircleAvatar(
//                     radius: 45,
//                     backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 30),
//
//             /// 3️⃣ CARD UI WITH FLOATING ACTION BUTTON
//             Text("3. Card with FAB", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Stack(
//               children: [
//                 Container(
//                   height: 140,
//                   width: double.infinity,
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     "This is a card UI.\nFAB is positioned bottom-right.",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   right: 10,
//                   child: FloatingActionButton(
//                     mini: true,
//                     onPressed: () {},
//                     child: Icon(Icons.add),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 30),
//
//             /// 4️⃣ CUSTOM BUTTON (ICON ABOVE TEXT)
//             Text("4. Custom Stack Button", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {},
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 20),
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       "Upload",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.cloud_upload, color: Colors.green),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';

/// ================= HOME PAGE =================
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stack Widget Demo")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            /// 1️⃣ IMAGE WITH OVERLAY TEXT
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/400"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Text(
                  "Overlay Text",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),

            SizedBox(height: 30),

            /// 2️⃣ PROFILE PAGE STACK
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.only(top: 60, bottom: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text("Dhruv Patel",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("Flutter Developer"),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150"),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            /// 3️⃣ CARD WITH FLOATING ACTION BUTTON
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "This is a Card UI with FAB using Stack",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {},
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            /// 4️⃣ CUSTOM STACK BUTTON → NEXT PAGE
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NextPage()),
                );
              },
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Next Page",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_forward, color: Colors.blue),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            /// UPLOAD BUTTON → UPLOAD PAGE
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UploadPage()),
                );
              },
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child:
                    Icon(Icons.cloud_upload, color: Colors.green),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// ================= NEXT PAGE =================
class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Page")),
      body: Center(
        child: Text("Next Page Opened 🚀", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

/// ================= UPLOAD PAGE =================
class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Page")),
      body: Center(
        child: Text("Upload Page Opened 📤", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
