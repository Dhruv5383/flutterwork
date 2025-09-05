// import 'package:flutter/material.dart';
//
// class MyPhotoApp extends StatelessWidget {
//   const MyPhotoApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Photo Post'),
//           backgroundColor: Colors.grey,
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(height: 200, width: 200, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),child: CircleAvatar(backgroundImage: AssetImage('assets/images/Bheem.jpg'),),),
//             SizedBox(width: 10),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.favorite_border),
//                   SizedBox(width: 16),
//                   Icon(Icons.chat_bubble_outline),
//                   SizedBox(width: 16),
//                   Icon(Icons.send_outlined),
//                 ],
//               ),
//             ),
//             Container(height: 200, width: 200, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),child: CircleAvatar(backgroundImage: AssetImage('assets/images/itachi.jpg'),),),
//           SizedBox(width: 10),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.favorite_border),
//                   SizedBox(width: 16),
//                   Icon(Icons.chat_bubble_outline),
//                   SizedBox(width: 16),
//                   Icon(Icons.send_outlined),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
//
// import 'package:flutter/material.dart';
//
// class MyListTile extends StatelessWidget {
//   const MyListTile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var images = [
//       'chair.jpeg',
//       'itachi.jpg',
//       'mobile.jpeg',
//       'shirt.jpeg',
//       'shoes.jpeg',
//       'table.jpeg',
//       'tanjiro.jpg',
//     ];
//     var names = [
//       'chair',
//       'itachi',
//       'mobile',
//       'shirt',
//       'shoes',
//       'table',
//       'tanjiro',
//     ];
//     var desc = [
//       'chair',
//       'itachi',
//       'mobile',
//       'shirt',
//       'shoes',
//       'table',
//       'tanjiro',
//     ];
//     return Scaffold(
//       appBar: AppBar(title: Text('ListTile'), backgroundColor: Colors.green),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: ListView.separated(
//           itemBuilder: (context, index) {
//             return ListTile(leading: CircleAvatar(backgroundImage: AssetImage('assets/images/${images[index]}'),),
//               title: Padding(padding: const EdgeInsets.only(left: 10), child: Text('${names[index]}', style: TextStyle(fontSize: 25)),),
//               subtitle: Padding(padding: const EdgeInsets.only(left: 10), child: Text('${desc[index]}', style: TextStyle(fontSize: 20)),),
//               trailing: Icon(Icons.density_medium),
//               // trailing: ,
//             );
//           },
//           separatorBuilder: (context, index) {
//             return Divider(height: 5, thickness: 2);
//           },
//           itemCount: images.length,
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// class InstagramUI extends StatelessWidget {
//   const InstagramUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var images =[
//       'car.jpeg',
//       'flower.jpeg',
//       'laptop.jpeg',
//       'phone.jpeg',
//       'shoes.jpeg',
//       'table.jpeg'
//     ];
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text('Instagram', style: TextStyle(color: Colors.black)),
//           actions: [
//             Icon(Icons.favorite_border, color: Colors.black),
//             SizedBox(width: 16),
//             Icon(Icons.message_outlined, color: Colors.black),
//             SizedBox(width: 10),
//           ],
//         ),
//         body: ListView(
//           children: [
//             // Stories
//             SizedBox(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 8,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.purple,
//                           child: CircleAvatar(
//                             radius: 28,
//                             backgroundImage: AssetImage('assets/images/itachi.jpg'), // add image in assets
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text('User$index', style: TextStyle(fontSize: 12)),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             Divider(),
//
//             // Post
//             ListTile(
//               leading: CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/Bheem.jpg'),
//               ),
//               title: Text('photosbyen'),
//               trailing: Icon(Icons.more_vert),
//             ),
//
//              Image.asset(
//                'assets/images/${images[index]}', // add your image in assets
//                height: 300,
//                width: double.infinity,
//                fit: BoxFit.cover,
//              ),
//             // Image.asset('assets/images/${images[index]}' ,
//             //   height: 300,
//             //   width: double.infinity,
//             //   fit: BoxFit.cover,),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
//                 IconButton(onPressed: () {}, icon: Icon(Icons.comment_outlined)),
//                 IconButton(onPressed: () {}, icon: Icon(Icons.send_outlined)),
//                 Spacer(),
//                 IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
//               ],
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text("Liked by kenzoere and others", style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }


// images add to mauti images
// import 'package:flutter/material.dart';
//
// class InstagramUI extends StatelessWidget {
//   const InstagramUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var images = [
//       'car.jpeg',
//       'flower.jpeg',
//       'laptop.jpeg',
//       'phone.jpeg',
//       'shoes.jpeg',
//       'table.jpeg'
//     ];
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text('Instagram', style: TextStyle(color: Colors.black)),
//           actions: [
//             Icon(Icons.favorite_border, color: Colors.black),
//             SizedBox(width: 16),
//             Icon(Icons.message_outlined, color: Colors.black),
//             SizedBox(width: 10),
//           ],
//         ),
//         body: ListView(
//           children: [
//             // Stories Section
//             SizedBox(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 8,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.purple,
//                           child: CircleAvatar(
//                             radius: 28,
//                             backgroundImage:
//                             AssetImage('assets/images/itachi.jpg'),
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text('User$index',
//                             style: TextStyle(fontSize: 12)),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             Divider(),
//
//             // Posts Section using ListView.builder
//             ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage:
//                         AssetImage('assets/images/Bheem.jpg'),
//                       ),
//                       title: Text('photosbyen'),
//                       trailing: Icon(Icons.more_vert),
//                     ),
//
//                     Image.asset(
//                       'assets/images/${images[index]}',
//                       height: 300,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.favorite_border)),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.comment_outlined)),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.send_outlined)),
//                         Spacer(),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.bookmark_border)),
//                       ],
//                     ),
//
//                     Padding(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         "Liked by kenzoere and others",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// title mauti add
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const InstagramUI());
// }
//
// class InstagramUI extends StatelessWidget {
//   const InstagramUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var images = [
//       'car.jpeg',
//       'flower.jpeg',
//       'laptop.jpeg',
//       'phone.jpeg',
//       'shoes.jpeg',
//       'table.jpeg'
//     ];
//
//     var names = [
//       'Car',
//       'Flower',
//       'Laptop',
//       'Phone',
//       'Shoes',
//       'Table'
//     ];
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text('Instagram', style: TextStyle(color: Colors.black)),
//           actions: [
//             Icon(Icons.favorite_border, color: Colors.black),
//             SizedBox(width: 16),
//             Icon(Icons.send,color: Colors.black),
//             SizedBox(width: 10),
//             //Icon(Icons.message_outlined, color: Colors.black),
//             //SizedBox(width: 10),
//           ],
//         ),
//         body: ListView(
//           children: [
//             // Stories Section
//             SizedBox(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 8,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.purple,
//                           child: CircleAvatar(
//                             radius: 28,
//                             backgroundImage:
//                             AssetImage('assets/images/itachi.jpg'),
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text('User$index',
//                             style: TextStyle(fontSize: 12)),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             Divider(),
//
//             // Posts Section using ListView.builder
//             ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage:
//                         AssetImage('assets/images/Bheem.jpg'),
//                       ),
//                       title: Text(names[index]), // 👈 Dynamic Name
//                       trailing: Icon(Icons.more_vert),
//                     ),
//
//                     Image.asset(
//                       'assets/images/${images[index]}',
//                       height: 300,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.favorite_border)),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.comment_outlined)),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.send_outlined)),
//                         Spacer(),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(Icons.bookmark_border)),
//                       ],
//                     ),
//
//                     Padding(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         "Liked by kenzoere and others",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//
//                     Padding(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
//                       child: Text(
//                         "Awesome ${names[index]} post!",
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                     ),
//
//                     SizedBox(height: 10),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// add to change to  backgroundimages in listtile  this is code
import 'package:flutter/material.dart';

class InstagramUI extends StatelessWidget {
  const InstagramUI({super.key});

  @override
  Widget build(BuildContext context) {
    var images = [
      'car.jpeg',
      'flower.jpeg',
      'laptop.jpeg',
      'phone.jpeg',
      'shoes.jpeg',
      'table.jpeg'
    ];

    var names = [
      'Car',
      'Flower',
      'Laptop',
      'Phone',
      'Shoes',
      'Table'
    ];

    var desc = [
      'car',
      'flower',
      'laptop',
      'phone',
      'shoes',
      'table'
    ];

    var c_backimages= [
      'Krishna.jpeg',
      'Bheem.jpg',
      'Jaggu.jpeg',
      'Chutki.jpg',
      'Motu.jpg',
      'Patlu.jpeg',
      'raju.jpeg',
      'Bholu.jpeg',
      'Dholu.jpeg',
      'Kalia.jpeg'

    ];
    var C_backimages_name= [
      'Krishna',
      'Bheem',
      'Jaggu',
      'Chutki',
      'Motu',
      'Patlu',
      'raju',
      'Bholu',
      'Dholu',
      'Kalia',

    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Instagram', style: TextStyle(color: Colors.black)),
          actions: [
            Icon(Icons.favorite_border, color: Colors.black),
            SizedBox(width: 16),
            Icon(Icons.send,color: Colors.black),
            SizedBox(width: 10),
            // Icon(Icons.message_outlined, color: Colors.black),
            // SizedBox(width: 10),
          ],
        ),
        body: ListView(
          children: [
            // Stories Section
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: C_backimages_name.length,
                itemBuilder: (context, index) {
                  return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.purple,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage:
                              AssetImage('assets/images/${c_backimages[index]}'),

                            ),
                          ),
                          SizedBox(height: 4),
                          Text(C_backimages_name[index],
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                },
              ),
            ),


            Divider(),

            // Posts Section using ListView.builder
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                        AssetImage('assets/images/${desc[index]}.jpeg'),
                      ),
                      title: Text(names[index]),
                      trailing: Icon(Icons.more_vert),
                    ),

                    Image.asset(
                      'assets/images/${images[index]}',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.comment_outlined)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.send_outlined)),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.bookmark_border)),
                      ],
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Liked by kenzoere and others",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4),
                      child: Text(
                        "Awesome ${names[index]} post!",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
