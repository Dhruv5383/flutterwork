import 'package:flutter/material.dart';

class MyColumn4 extends StatelessWidget {
  const MyColumn4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task 4'), backgroundColor: Colors.green),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(color: Colors.grey, height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 100, width: 100, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue),child: CircleAvatar(backgroundImage: AssetImage('assets/images/itachi.jpg'),),),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),child: CircleAvatar(backgroundImage: AssetImage('assets/images/Bheem.jpg'),),),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100,decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow,),child: CircleAvatar(backgroundImage: AssetImage('assets/images/Chutki.jpg'),),),
                        SizedBox(width: 10),
                        Container(height: 100,width: 100,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.greenAccent,),child: CircleAvatar(backgroundImage: AssetImage('assets/images/raju.jpeg'),),),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100,decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),child: CircleAvatar(backgroundImage: AssetImage('assets/images/Jaggu.jpeg'),),),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),child: CircleAvatar(backgroundImage: AssetImage('assets/images/Kalia.jpeg'),),),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.yellow,),child: CircleAvatar(backgroundImage: AssetImage('assets/images/Bholu.jpeg'),),),
                        SizedBox(width: 10),
                        Container(height: 100, width: 100,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.greenAccent,),child: CircleAvatar(backgroundImage: AssetImage('assets/images/Dholu.jpeg'),),),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(height: 400,width: 900, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/itachi.jpg'),),),),
                SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Bheem.jpg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Chutki.jpg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/raju.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Jaggu.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Kalia.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Bholu.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Dholu.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Rajkumari.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Krishna.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Motu.jpg'),),),),
                SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
                Container(height: 400, width: 300, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/Patlu.jpeg'),),),),
                SizedBox(height: 20),const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
