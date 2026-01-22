// import 'package:flutter/material.dart';
//
// class ExpandCollapseSection extends StatefulWidget {
//   @override
//   State<ExpandCollapseSection> createState() => _ExpandCollapseSectionState();
// }
//
// class _ExpandCollapseSectionState extends State<ExpandCollapseSection> {
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AnimatedContainer Expand'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   isExpanded = !isExpanded;
//                 });
//               },
//               child: Text(isExpanded ? 'Collapse' : 'Expand'),
//             ),
//             SizedBox(height: 16),
//
//             AnimatedContainer(
//               duration: Duration(milliseconds: 400),
//               curve: Curves.easeInOut,
//               height: isExpanded ? 150 : 0,
//               width: double.infinity,
//               padding: EdgeInsets.all(isExpanded ? 16 : 0),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade100,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: SingleChildScrollView(
//                 child: Opacity(
//                   opacity: isExpanded ? 1 : 0,
//                   child: Text(
//                     'This is expandable content.\n'
//                         'You can place text, images, or any widget here.\n\n'
//                         'AnimatedContainer smoothly animates the height.',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





//g
// import 'package:flutter/material.dart';
//
// class ExpandableContentScreen extends StatefulWidget {
//   const ExpandableContentScreen({super.key});
//
//   @override
//   State<ExpandableContentScreen> createState() => _ExpandableContentScreenState();
// }
//
// class _ExpandableContentScreenState extends State<ExpandableContentScreen> {
//   // 1. Track whether the section is expanded or not
//   bool _isExpanded = false;
//
//   void _toggleExpand() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Animated Expansion"),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // 2. The Trigger Button
//             ElevatedButton.icon(
//               onPressed: _toggleExpand,
//               icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
//               label: Text(_isExpanded ? "Collapse Details" : "Expand Details"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.indigo,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // 3. The AnimatedContainer
//             // It will automatically animate whenever its properties (height/color) change
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.fastOutSlowIn,
//               width: double.infinity,
//               // Toggle height: 0 when collapsed, 150 when expanded
//               height: _isExpanded ? 150 : 0,
//               decoration: BoxDecoration(
//                 color: _isExpanded ? Colors.indigo[50] : Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: _isExpanded ? Colors.indigo : Colors.transparent,
//                 ),
//               ),
//               // Use Clip.antiAlias to hide child content when height is 0
//               clipBehavior: Clip.antiAlias,
//               child: const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Section Title",
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "This is the hidden content that appears when you click the button. "
//                           "The AnimatedContainer handles the smooth transition of the height "
//                           "property using the specified duration and curve.",
//                       style: TextStyle(color: Colors.black87),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// level 1
// import 'package:flutter/material.dart';
//
// class AutoExpandSection extends StatefulWidget {
//   @override
//   State<AutoExpandSection> createState() => _AutoExpandSectionState();
// }
//
// class _AutoExpandSectionState extends State<AutoExpandSection> {
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Auto Expand Section'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   isExpanded = !isExpanded;
//                 });
//               },
//               child: Text(isExpanded ? 'Hide Details' : 'Show Details'),
//             ),
//             SizedBox(height: 16),
//
//             AnimatedContainer(
//               duration: Duration(milliseconds: 400),
//               curve: Curves.easeInOut,
//               width: double.infinity,
//               padding: EdgeInsets.all(isExpanded ? 16 : 0),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade100,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: AnimatedOpacity(
//                 duration: Duration(milliseconds: 300),
//                 opacity: isExpanded ? 1 : 0,
//                 child: isExpanded
//                     ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Expandable Content',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'This section automatically adjusts its height '
//                           'based on the content inside.\n\n'
//                           'Perfect for FAQs, settings, and details panels.',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 )
//                     : SizedBox.shrink(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// level 2
// import 'package:flutter/material.dart';
//
// class AccordionDemo extends StatefulWidget {
//   @override
//   State<AccordionDemo> createState() => _AccordionDemoState();
// }
//
// class _AccordionDemoState extends State<AccordionDemo> {
//   int expandedIndex = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Accordion AnimatedContainer'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: List.generate(3, (index) {
//           bool isOpen = expandedIndex == index;
//
//           return Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     expandedIndex = isOpen ? -1 : index;
//                   });
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Section ${index + 1}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       AnimatedRotation(
//                         turns: isOpen ? 0.5 : 0,
//                         duration: Duration(milliseconds: 300),
//                         child: Icon(
//                           Icons.keyboard_arrow_down,
//                           color: Colors.white,
//                           size: 28,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               AnimatedContainer(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//                 margin: EdgeInsets.only(bottom: 16),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: isOpen ? 16 : 0,
//                 ),
//                 height: isOpen ? null : 0,
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: AnimatedOpacity(
//                   opacity: isOpen ? 1 : 0,
//                   duration: Duration(milliseconds: 300),
//                   child: AnimatedSlide(
//                     offset: isOpen ? Offset(0, 0) : Offset(0, -0.1),
//                     duration: Duration(milliseconds: 300),
//                     child: Text(
//                       'This is the content of section ${index + 1}.\n'
//                           'You can place any widget here.\n'
//                           'Height adjusts automatically.',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }







//
// import 'package:flutter/material.dart';
//
// class ExpandTileDemo extends StatefulWidget {
//   @override
//   State<ExpandTileDemo> createState() => _ExpandTileDemoState();
// }
//
// class _ExpandTileDemoState extends State<ExpandTileDemo> {
//   int openIndex = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reusable ExpandTile'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16),
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return ExpandTile(
//             title: 'Item ${index + 1}',
//             isExpanded: openIndex == index,
//             onTap: () {
//               setState(() {
//                 openIndex = openIndex == index ? -1 : index;
//               });
//             },
//             child: Text(
//               'This is expandable content for item ${index + 1}.\n'
//                   'Perfect for FAQs, settings, or lists.',
//               style: TextStyle(fontSize: 16),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ExpandTile extends StatefulWidget {
//   final String title;
//   final bool isExpanded;
//   final VoidCallback onTap;
//   final Widget child;
//
//   const ExpandTile({
//     required this.title,
//     required this.isExpanded,
//     required this.onTap,
//     required this.child,
//   });
//
//   @override
//   State<ExpandTile> createState() => _ExpandTileState();
// }
//
// class _ExpandTileState extends State<ExpandTile> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: widget.onTap,
//           child: Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.indigo,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 AnimatedRotation(
//                   turns: widget.isExpanded ? 0.5 : 0,
//                   duration: Duration(milliseconds: 300),
//                   child: Icon(
//                     Icons.expand_more,
//                     color: Colors.white,
//                     size: 28,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         AnimatedContainer(
//           duration: Duration(milliseconds: 400),
//           curve: Curves.easeInOut,
//           padding: EdgeInsets.all(widget.isExpanded ? 16 : 0),
//           margin: EdgeInsets.only(bottom: 16),
//           decoration: BoxDecoration(
//             color: Colors.indigo.shade50,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: ClipRect(
//             child: AnimatedOpacity(
//               opacity: widget.isExpanded ? 1 : 0,
//               duration: Duration(milliseconds: 300),
//               child: AnimatedSlide(
//                 offset: widget.isExpanded
//                     ? Offset(0, 0)
//                     : Offset(0, -0.1),
//                 duration: Duration(milliseconds: 300),
//                 child: widget.child,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }






// final 

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvancedExpandDemo extends StatefulWidget {
  @override
  State<AdvancedExpandDemo> createState() => _AdvancedExpandDemoState();
}

class _AdvancedExpandDemoState extends State<AdvancedExpandDemo> {
  int expandedIndex = -1;

  final Curve motionCurve = Curves.easeInOutCubicEmphasized;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      expandedIndex = prefs.getInt('expandedIndex') ?? -1;
    });
  }

  Future<void> _saveState(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('expandedIndex', index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Expand UI'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          bool isOpen = expandedIndex == index;

          return TimelineExpandTile(
            title: 'FAQ Question ${index + 1}',
            isExpanded: isOpen,
            curve: motionCurve,
            onTap: () {
              setState(() {
                expandedIndex = isOpen ? -1 : index;
                _saveState(expandedIndex);
              });
            },
          );
        },
      ),
    );
  }
}

class TimelineExpandTile extends StatefulWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Curve curve;

  const TimelineExpandTile({
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.curve,
  });

  @override
  State<TimelineExpandTile> createState() => _TimelineExpandTileState();
}

class _TimelineExpandTileState extends State<TimelineExpandTile> {
  bool nestedOpen = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: widget.isExpanded ? 160 : 40,
              color: Colors.indigo.shade200,
            ),
          ],
        ),
        SizedBox(width: 12),

        // Content
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: widget.isExpanded ? 0.5 : 0,
                        duration: Duration(milliseconds: 350),
                        curve: widget.curve,
                        child: Icon(
                          Icons.expand_more,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: widget.curve,
                padding: EdgeInsets.all(widget.isExpanded ? 16 : 0),
                margin: EdgeInsets.only(top: 8, bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRect(
                  child: AnimatedOpacity(
                    opacity: widget.isExpanded ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'This section auto-sizes based on content.\n'
                              'State is persisted using SharedPreferences.',
                          style: TextStyle(fontSize: 16),
                        ),

                        SizedBox(height: 12),

                        // 🔁 Nested expandable section
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              nestedOpen = !nestedOpen;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'More details',
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AnimatedRotation(
                                turns: nestedOpen ? 0.5 : 0,
                                duration: Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ),

                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: widget.curve,
                          padding:
                          EdgeInsets.all(nestedOpen ? 12 : 0),
                          child: AnimatedOpacity(
                            opacity: nestedOpen ? 1 : 0,
                            duration: Duration(milliseconds: 300),
                            child: Text(
                              'Nested expandable content.\n'
                                  'Perfect for sub-FAQs or advanced details.',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
