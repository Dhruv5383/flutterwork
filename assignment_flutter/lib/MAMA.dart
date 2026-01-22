// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class FamilyMFTrackerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Family MF Tracker Pro',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: FamilyMFTracker(),
//     );
//   }
// }
//
// class FamilyMFTracker extends StatefulWidget {
//   @override
//   _FamilyMFTrackerState createState() => _FamilyMFTrackerState();
// }
//
// class _FamilyMFTrackerState extends State<FamilyMFTracker> {
//   Map<String, List<Investment>> familyData = {};
//   int selectedMemberIndex = -1;
//
//   Future<Map<String, dynamic>> getLiveNav(String code) async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://api.mfapi.in/mf/$code'),
//         headers: {'User-Agent': 'FamilyMFTracker/1.0'},
//       ).timeout(Duration(seconds: 10));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return {
//           'success': true,
//           'name': data['meta']['scheme_name'],
//           'nav': double.parse(data['data'][0]['nav']),
//         };
//       }
//     } catch (e) {
//       print('Error fetching NAV: $e');
//     }
//     return {'success': false, 'name': null, 'nav': 0.0};
//   }
//
//   // void addMember(String name) {
//   //   if (!familyData.containsKey(name)) {
//   //     setState(() {
//   //       familyData[name] = [];
//   //     });
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('✅ $name added to family!')),
//   //     );
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('⚠️ Member already exists!')),
//   //     );
//   //   }
//   // }
//
//   void addMember(String name) async {
//     if (!familyData.containsKey(name)) {
//       setState(() {
//         familyData[name] = [];
//       });
//
//       final prefs = await SharedPreferences.getInstance();
//       final names = familyData.keys.toList();
//       await prefs.setStringList('family_members', names);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('✅ $name added to family!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('⚠️ Member already exists!')),
//       );
//     }
//   }
//
//
//   void addInvestment(String code, double units, double buyPrice) async {
//     if (selectedMemberIndex == -1) return;
//
//     final memberName = familyData.keys.elementAt(selectedMemberIndex);
//     final navData = await getLiveNav(code);
//
//     if (navData['success']) {
//       setState(() {
//         familyData[memberName]!.add(Investment(
//           code: code,
//           name: navData['name'],
//           units: units,
//           buyPrice: buyPrice,
//         ));
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('✅ ${navData['name']} saved for $memberName')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Invalid MF Code!')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('🏠 Family MF Tracker Pro')),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Member List
//             Expanded(
//               flex: 2,
//               child: Column(
//                 children: [
//                   Text('👥 Family Members', style: Theme.of(context).textTheme.headlineSmall),
//                   SizedBox(height: 10),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: familyData.length,
//                       itemBuilder: (context, index) {
//                         final member = familyData.keys.elementAt(index);
//                         return ListTile(
//                           title: Text(member),
//                           subtitle: Text('${familyData[member]!.length} funds'),
//                           selected: selectedMemberIndex == index,
//                           selectedTileColor: Colors.blue.withOpacity(0.1),
//                           onTap: () => setState(() => selectedMemberIndex = index),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Add Member Button
//             ElevatedButton.icon(
//               onPressed: () => _showAddMemberDialog(),
//               icon: Icon(Icons.person_add),
//               label: Text('Add Family Member'),
//               style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
//             ),
//
//             SizedBox(height: 10),
//
//             // Add Investment Button
//             ElevatedButton.icon(
//               onPressed: selectedMemberIndex != -1 ? () => _showAddInvestmentDialog() : null,
//               icon: Icon(Icons.add_chart),
//               label: Text('Add Investment'),
//               style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
//             ),
//
//             SizedBox(height: 20),
//
//             // View Report Button
//             ElevatedButton.icon(
//               onPressed: familyData.isNotEmpty ? _showReport : null,
//               icon: Icon(Icons.analytics),
//               label: Text('View Live Report'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 50),
//                 backgroundColor: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddMemberDialog() {
//     String name = '';
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Add Family Member'),
//         content: TextField(
//           decoration: InputDecoration(hintText: 'Enter name'),
//           onChanged: (value) => name = value.trim(),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
//           ElevatedButton(
//             onPressed: name.isEmpty ? null : () {
//               addMember(name);
//               Navigator.pop(context);
//             },
//             child: Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadFamilyMembers();
//   }
//
//   Future<void> _loadFamilyMembers() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedNames = prefs.getStringList('family_members') ?? [];
//
//     setState(() {
//       for (var name in savedNames) {
//         familyData[name] = [];
//       }
//     });
//   }
//
//
//   void _showAddInvestmentDialog() async {
//     final memberName = familyData.keys.elementAt(selectedMemberIndex);
//     String code = '';
//     double units = 0;
//     double buyPrice = 0;
//
//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setDialogState) => AlertDialog(
//           title: Text('Add Investment for $memberName'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'MF Code (e.g., 118989)'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) => code = value.trim(),
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Units Owned'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) => units = double.tryParse(value) ?? 0,
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Average Buy NAV'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) => buyPrice = double.tryParse(value) ?? 0,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
//             ElevatedButton(
//               onPressed: code.isEmpty || units <= 0 || buyPrice <= 0 ? null : () {
//                 addInvestment(code, units, buyPrice);
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showReport() {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         child: Container(
//           width: double.infinity,
//           constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('🏠 FAMILY WEALTH REPORT', style: Theme.of(context).textTheme.headlineMedium),
//               SizedBox(height: 20),
//               Expanded(child: FutureBuilder<List<ReportRow>>(
//                 future: _generateReportRows(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//
//                   final rows = snapshot.data!;
//                   double grandTotalInvested = 0;
//                   double grandTotalCurrent = 0;
//
//                   return ListView.separated(
//                     itemCount: rows.length,
//                     separatorBuilder: (_,__) => Divider(),
//                     itemBuilder: (context, index) {
//                       final row = rows[index];
//                       if (row.isMemberTotal) {
//                         grandTotalInvested += row.invested;
//                         grandTotalCurrent += row.current;
//                         return ListTile(
//                           title: Text('${row.title} SUBTOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
//                           trailing: Text(
//                             '${row.invested.toStringAsFixed(2).padLeft(10)} | '
//                                 '${row.current.toStringAsFixed(2).padLeft(10)} | '
//                                 '${row.gainPct.toStringAsFixed(2)}%',
//                             textAlign: TextAlign.right,
//                           ),
//                         );
//                       } else if (row.isGrandTotal) {
//                         return Container(
//                           color: Colors.green.withOpacity(0.1),
//                           padding: EdgeInsets.all(16),
//                           child: Column(
//                             children: [
//                               Text('🌍 TOTAL FAMILY NET WORTH: ₹${grandTotalCurrent.toStringAsFixed(2)}'),
//                               Text('📈 TOTAL FAMILY PROFIT: ₹${(grandTotalCurrent - grandTotalInvested).toStringAsFixed(2)}'),
//                             ],
//                           ),
//                         );
//                       }
//                       return ListTile(
//                         title: Text(row.title),
//                         trailing: Text(
//                           '${row.invested.toStringAsFixed(2).padLeft(10)} | '
//                               '${row.current.toStringAsFixed(2).padLeft(10)} | '
//                               '${row.gainPct.toStringAsFixed(2)}%',
//                           textAlign: TextAlign.right,
//                         ),
//                       );
//                     },
//                   );
//                 },
//               )),
//               SizedBox(height: 20),
//               TextButton.icon(
//                 onPressed: () => Navigator.pop(context),
//                 icon: Icon(Icons.close),
//                 label: Text('Close'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<List<ReportRow>> _generateReportRows() async {
//     List<ReportRow> rows = [];
//     double grandTotalInvested = 0;
//     double grandTotalCurrent = 0;
//
//     for (int i = 0; i < familyData.length; i++) {
//       final member = familyData.keys.elementAt(i);
//       final funds = familyData[member]!;
//
//       rows.add(ReportRow(title: '👤 MEMBER: $member', invested: 0, current: 0, gainPct: 0, isMemberTotal: true));
//
//       double memberInvested = 0;
//       double memberCurrent = 0;
//
//       for (var fund in funds) {
//         final navData = await getLiveNav(fund.code);
//         final liveNav = navData['success'] ? navData['nav'] as double : 0.0;
//         final invested = fund.units * fund.buyPrice;
//         final current = fund.units * liveNav;
//         final gainPct = invested > 0 ? ((current - invested) / invested * 100) : 0.0;
//
//         rows.add(ReportRow(
//           title: fund.name.substring(0, fund.name.length.clamp(0, 28)),
//           invested: invested,
//           current: current,
//           gainPct: gainPct,
//         ));
//
//         memberInvested += invested;
//         memberCurrent += current;
//       }
//
//       final memberGain = memberInvested > 0 ? ((memberCurrent - memberInvested) / memberInvested * 100) : 0.0;
//       rows.add(ReportRow(
//         title: 'SUBTOTAL',
//         invested: memberInvested,
//         current: memberCurrent,
//         gainPct: memberGain,
//         isMemberTotal: true,
//       ));
//
//       grandTotalInvested += memberInvested;
//       grandTotalCurrent += memberCurrent;
//     }
//
//     rows.add(ReportRow(
//       title: '',
//       invested: grandTotalInvested,
//       current: grandTotalCurrent,
//       gainPct: grandTotalInvested > 0 ? ((grandTotalCurrent - grandTotalInvested) / grandTotalInvested * 100) : 0.0,
//       isGrandTotal: true,
//     ));
//
//     return rows;
//   }
// }
//
// class Investment {
//   final String code;
//   final String name;
//   final double units;
//   final double buyPrice;
//
//   Investment({required this.code, required this.name, required this.units, required this.buyPrice});
// }
//
// class ReportRow {
//   final String title;
//   final double invested;
//   final double current;
//   final double gainPct;
//   final bool isMemberTotal;
//   final bool isGrandTotal;
//
//   ReportRow({
//     required this.title,
//     required this.invested,
//     required this.current,
//     required this.gainPct,
//     this.isMemberTotal = false,
//     this.isGrandTotal = false,
//   });
// }


//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class FamilyMFTracker extends StatefulWidget {
//   const FamilyMFTracker({super.key});
//
//   @override
//   State<FamilyMFTracker> createState() => _FamilyMFTrackerState();
// }
//
// class _FamilyMFTrackerState extends State<FamilyMFTracker> {
//   /// Virtual DB (same as Python dict)
//   Map<String, List<Map<String, dynamic>>> familyData = {};
//
//   /// Fetch live NAV
//   Future<Map<String, dynamic>?> getLiveNav(String code) async {
//     try {
//       final url = Uri.parse("https://api.mfapi.in/mf/$code");
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return {
//           "name": data['meta']['scheme_name'],
//           "nav": double.parse(data['data'][0]['nav'])
//         };
//       }
//     } catch (_) {}
//     return null;
//   }
//
//   /// Add family member
//   void addMember() {
//     final controller = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Add Family Member"),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(hintText: "Member name"),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               final name = controller.text.trim();
//               if (name.isNotEmpty && !familyData.containsKey(name)) {
//                 setState(() => familyData[name] = []);
//               }
//               Navigator.pop(context);
//             },
//             child: const Text("ADD"),
//           )
//         ],
//       ),
//     );
//   }
//
//   /// Add investment
//   void addInvestment(String member) {
//     final codeCtrl = TextEditingController();
//     final unitCtrl = TextEditingController();
//     final buyCtrl = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Add Investment for $member"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(controller: codeCtrl, decoration: const InputDecoration(labelText: "MF Code")),
//             TextField(controller: unitCtrl, decoration: const InputDecoration(labelText: "Units")),
//             TextField(controller: buyCtrl, decoration: const InputDecoration(labelText: "Buy NAV")),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               final fund = await getLiveNav(codeCtrl.text);
//               if (fund != null) {
//                 setState(() {
//                   familyData[member]!.add({
//                     "code": codeCtrl.text,
//                     "name": fund["name"],
//                     "units": double.parse(unitCtrl.text),
//                     "buy_price": double.parse(buyCtrl.text),
//                   });
//                 });
//               }
//               Navigator.pop(context);
//             },
//             child: const Text("SAVE"),
//           )
//         ],
//       ),
//     );
//   }
//
//   /// Calculate totals
//   double totalCurrentValue() {
//     double total = 0;
//     for (var member in familyData.values) {
//       for (var fund in member) {
//         total += fund["units"] * fund["buy_price"];
//       }
//     }
//     return total;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Family MF Tracker Pro"),
//         actions: [
//           IconButton(onPressed: addMember, icon: const Icon(Icons.person_add))
//         ],
//       ),
//       body: familyData.isEmpty
//           ? const Center(child: Text("No family members added"))
//           : ListView(
//         children: familyData.entries.map((entry) {
//           return Card(
//             margin: const EdgeInsets.all(10),
//             child: ExpansionTile(
//               title: Text(entry.key, style: const TextStyle(fontSize: 18)),
//               children: [
//                 ...entry.value.map((fund) {
//                   return ListTile(
//                     title: Text(fund["name"]),
//                     subtitle: Text(
//                         "Units: ${fund["units"]} | Buy NAV: ${fund["buy_price"]}"),
//                   );
//                 }),
//                 TextButton.icon(
//                   onPressed: () => addInvestment(entry.key),
//                   icon: const Icon(Icons.add),
//                   label: const Text("Add Investment"),
//                 )
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         color: Colors.blue.shade50,
//         child: Text(
//           "Total Invested (Approx): ₹${totalCurrentValue().toStringAsFixed(2)}",
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }


//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MFApp());
// }
//
// class MFApp extends StatelessWidget {
//   const MFApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Map<String, List<Map<String, dynamic>>> familyData = {};
//
//   // ---------------- STORAGE ----------------
//   Future<void> saveData() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("familyData", jsonEncode(familyData));
//   }
//
//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString("familyData");
//     if (data != null) {
//       setState(() {
//         familyData = Map<String, List<Map<String, dynamic>>>.from(
//           jsonDecode(data).map(
//                 (k, v) => MapEntry(k, List<Map<String, dynamic>>.from(v)),
//           ),
//         );
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   // ---------------- API ----------------
//   Future<Map<String, dynamic>?> getLiveNav(String code) async {
//     try {
//       final res = await http.get(Uri.parse("https://api.mfapi.in/mf/$code"));
//       final data = jsonDecode(res.body);
//       return {
//         "name": data['meta']['scheme_name'],
//         "nav": double.parse(data['data'][0]['nav'])
//       };
//     } catch (_) {
//       return null;
//     }
//   }
//
//   // ---------------- UI ACTIONS ----------------
//   void addMember() {
//     final ctrl = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Add Family Member"),
//         content: TextField(controller: ctrl),
//         actions: [
//           TextButton(
//             onPressed: () {
//               if (ctrl.text.isNotEmpty) {
//                 setState(() => familyData[ctrl.text] = []);
//                 saveData();
//               }
//               Navigator.pop(context);
//             },
//             child: const Text("ADD"),
//           )
//         ],
//       ),
//     );
//   }
//
//   void addFund(String member) {
//     final code = TextEditingController();
//     final unit = TextEditingController();
//     final buy = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Add Fund → $member"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(controller: code, decoration: const InputDecoration(labelText: "MF Code")),
//             TextField(controller: unit, decoration: const InputDecoration(labelText: "Units")),
//             TextField(controller: buy, decoration: const InputDecoration(labelText: "Buy NAV")),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               final fund = await getLiveNav(code.text);
//               if (fund != null) {
//                 setState(() {
//                   familyData[member]!.add({
//                     "code": code.text,
//                     "name": fund["name"],
//                     "units": double.parse(unit.text),
//                     "buy": double.parse(buy.text),
//                   });
//                 });
//                 saveData();
//               }
//               Navigator.pop(context);
//             },
//             child: const Text("SAVE"),
//           )
//         ],
//       ),
//     );
//   }
//
//   // ---------------- TOTALS ----------------
//   Future<Map<String, double>> totals() async {
//     double invested = 0, current = 0;
//
//     for (var m in familyData.values) {
//       for (var f in m) {
//         final live = await getLiveNav(f["code"]);
//         if (live != null) {
//           invested += f["units"] * f["buy"];
//           current += f["units"] * live["nav"];
//         }
//       }
//     }
//     return {
//       "invested": invested,
//       "current": current,
//       "profit": current - invested
//     };
//   }
//
//   // ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Family MF Tracker Pro"),
//         actions: [
//           IconButton(onPressed: addMember, icon: const Icon(Icons.person_add))
//         ],
//       ),
//       body: familyData.isEmpty
//           ? const Center(child: Text("No Family Members"))
//           : ListView(
//         children: familyData.entries.map((e) {
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: ExpansionTile(
//               title: Text(e.key),
//               children: [
//                 ...e.value.map((f) {
//                   return FutureBuilder(
//                     future: getLiveNav(f["code"]),
//                     builder: (c, s) {
//                       if (!s.hasData) {
//                         return const LinearProgressIndicator();
//                       }
//                       final nav = (s.data as Map)["nav"];
//                       final invested = f["units"] * f["buy"];
//                       final current = f["units"] * nav;
//                       final gain = current - invested;
//
//                       return ListTile(
//                         title: Text(f["name"]),
//                         subtitle: Text(
//                           "Invested ₹${invested.toStringAsFixed(2)} | "
//                               "Current ₹${current.toStringAsFixed(2)}",
//                         ),
//                         trailing: Text(
//                           "${gain >= 0 ? "+" : ""}${gain.toStringAsFixed(2)}",
//                           style: TextStyle(
//                             color: gain >= 0 ? Colors.green : Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         onLongPress: () {
//                           setState(() {
//                             e.value.remove(f);
//                             saveData();
//                           });
//                         },
//                       );
//                     },
//                   );
//                 }),
//                 TextButton.icon(
//                   onPressed: () => addFund(e.key),
//                   icon: const Icon(Icons.add),
//                   label: const Text("Add Fund"),
//                 )
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//       bottomNavigationBar: FutureBuilder(
//         future: totals(),
//         builder: (c, s) {
//           if (!s.hasData) return const SizedBox(height: 60);
//           final t = s.data as Map<String, double>;
//           return Container(
//             padding: const EdgeInsets.all(16),
//             color: Colors.blue.shade50,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text("🌍 Net Worth: ₹${t["current"]!.toStringAsFixed(2)}",
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text(
//                   "📈 Profit: ₹${t["profit"]!.toStringAsFixed(2)}",
//                   style: TextStyle(
//                     color: t["profit"]! >= 0 ? Colors.green : Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }









//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class MFHomePage extends StatefulWidget {
//   const MFHomePage({super.key});
//
//   @override
//   State<MFHomePage> createState() => _MFHomePageState();
// }
//
// class _MFHomePageState extends State<MFHomePage> {
//   /// Same as Python `family_data`
//   Map<String, List<Map<String, dynamic>>> familyData = {};
//
//   // ---------------- STORAGE ----------------
//   Future<void> saveData() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("familyData", jsonEncode(familyData));
//   }
//
//   Future<void> loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString("familyData");
//     if (data != null) {
//       setState(() {
//         familyData = Map<String, List<Map<String, dynamic>>>.from(
//           jsonDecode(data).map(
//                 (k, v) => MapEntry(k, List<Map<String, dynamic>>.from(v)),
//           ),
//         );
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   // ---------------- MF API ----------------
//   Future<Map<String, dynamic>?> getLiveNav(String code) async {
//     try {
//       final res = await http.get(Uri.parse("https://api.mfapi.in/mf/$code"));
//       final data = jsonDecode(res.body);
//       return {
//         "name": data['meta']['scheme_name'],
//         "nav": double.parse(data['data'][0]['nav']),
//       };
//     } catch (_) {
//       return null;
//     }
//   }
//
//   // ---------------- ADD MEMBER ----------------
//   void addMember() {
//     final ctrl = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Add Family Member"),
//         content: TextField(controller: ctrl),
//         actions: [
//           TextButton(
//             onPressed: () {
//               if (ctrl.text.isNotEmpty) {
//                 setState(() => familyData[ctrl.text] = []);
//                 saveData();
//               }
//               Navigator.pop(context);
//             },
//             child: const Text("ADD"),
//           )
//         ],
//       ),
//     );
//   }
//
//   // ---------------- ADD FUND ----------------
//   void addFund(String member) {
//     final code = TextEditingController();
//     final units = TextEditingController();
//     final buy = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Add Investment → $member"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(controller: code, decoration: const InputDecoration(labelText: "MF Code")),
//             TextField(controller: units, decoration: const InputDecoration(labelText: "Units")),
//             TextField(controller: buy, decoration: const InputDecoration(labelText: "Buy NAV")),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               final fund = await getLiveNav(code.text);
//               if (fund != null) {
//                 setState(() {
//                   familyData[member]!.add({
//                     "code": code.text,
//                     "name": fund["name"],
//                     "units": double.parse(units.text),
//                     "buy": double.parse(buy.text),
//                   });
//                 });
//                 saveData();
//               }
//               Navigator.pop(context);
//             },
//             child: const Text("SAVE"),
//           )
//         ],
//       ),
//     );
//   }
//
//   // ---------------- TOTALS ----------------
//   Future<Map<String, double>> calculateTotals() async {
//     double invested = 0, current = 0;
//
//     for (var member in familyData.values) {
//       for (var fund in member) {
//         final live = await getLiveNav(fund["code"]);
//         if (live != null) {
//           invested += fund["units"] * fund["buy"];
//           current += fund["units"] * live["nav"];
//         }
//       }
//     }
//     return {
//       "invested": invested,
//       "current": current,
//       "profit": current - invested,
//     };
//   }
//
//   // ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Family MF Tracker Pro"),
//         actions: [
//           IconButton(onPressed: addMember, icon: const Icon(Icons.person_add))
//         ],
//       ),
//       body: familyData.isEmpty
//           ? const Center(child: Text("No Family Members Added"))
//           : ListView(
//         children: familyData.entries.map((entry) {
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: ExpansionTile(
//               title: Text(entry.key),
//               children: [
//                 ...entry.value.map((fund) {
//                   return FutureBuilder(
//                     future: getLiveNav(fund["code"]),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const LinearProgressIndicator();
//                       }
//
//                       final nav = (snapshot.data as Map)["nav"];
//                       final invested = fund["units"] * fund["buy"];
//                       final current = fund["units"] * nav;
//                       final gain = current - invested;
//                       final gainPct =
//                       invested > 0 ? (gain / invested * 100) : 0;
//
//                       return ListTile(
//                         title: Text(fund["name"]),
//                         subtitle: Text(
//                           "Invested ₹${invested.toStringAsFixed(2)} | "
//                               "Current ₹${current.toStringAsFixed(2)}",
//                         ),
//                         trailing: Text(
//                           "${gain >= 0 ? "+" : ""}${gain.toStringAsFixed(2)}\n(${gainPct.toStringAsFixed(2)}%)",
//                           textAlign: TextAlign.right,
//                           style: TextStyle(
//                             color: gain >= 0 ? Colors.green : Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         onLongPress: () {
//                           setState(() {
//                             entry.value.remove(fund);
//                             saveData();
//                           });
//                         },
//                       );
//                     },
//                   );
//                 }),
//                 TextButton.icon(
//                   onPressed: () => addFund(entry.key),
//                   icon: const Icon(Icons.add),
//                   label: const Text("Add Investment"),
//                 )
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//       bottomNavigationBar: FutureBuilder(
//         future: calculateTotals(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return const SizedBox(height: 60);
//           final t = snapshot.data as Map<String, double>;
//           return Container(
//             padding: const EdgeInsets.all(16),
//             color: Colors.blue.shade50,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "🌍 Total Family Net Worth: ₹${t["current"]!.toStringAsFixed(2)}",
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "📈 Profit / Loss: ₹${t["profit"]!.toStringAsFixed(2)}",
//                   style: TextStyle(
//                     color: t["profit"]! >= 0 ? Colors.green : Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }









import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class MFHomePage extends StatefulWidget {
  const MFHomePage({super.key});

  @override
  State<MFHomePage> createState() => _MFHomePageState();
}

class _MFHomePageState extends State<MFHomePage> {
  Map<String, List<Map<String, dynamic>>> familyData = {};

  // ================= STORAGE =================
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("familyData", jsonEncode(familyData));
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("familyData");
    if (data != null) {
      setState(() {
        familyData = Map<String, List<Map<String, dynamic>>>.from(
          jsonDecode(data).map(
                (k, v) => MapEntry(k, List<Map<String, dynamic>>.from(v)),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ================= MF API =================
  Future<Map<String, dynamic>?> getLiveNav(String code) async {
    try {
      final res = await http.get(Uri.parse("https://api.mfapi.in/mf/$code"));
      final data = jsonDecode(res.body);
      return {
        "name": data['meta']['scheme_name'],
        "nav": double.parse(data['data'][0]['nav']),
      };
    } catch (_) {
      return null;
    }
  }

  // ================= ADD MEMBER =================
  void addMember() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Family Member"),
        content: TextField(controller: ctrl),
        actions: [
          TextButton(
            onPressed: () {
              if (ctrl.text.isNotEmpty) {
                setState(() => familyData[ctrl.text] = []);
                saveData();
              }
              Navigator.pop(context);
            },
            child: const Text("ADD"),
          )
        ],
      ),
    );
  }

  // ================= ADD FUND =================
  void addFund(String member) {
    final code = TextEditingController();
    final units = TextEditingController();
    final buy = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Investment → $member"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: code, decoration: const InputDecoration(labelText: "MF Code")),
            TextField(controller: units, decoration: const InputDecoration(labelText: "Units")),
            TextField(controller: buy, decoration: const InputDecoration(labelText: "Buy NAV")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final fund = await getLiveNav(code.text);
              if (fund != null) {
                setState(() {
                  familyData[member]!.add({
                    "code": code.text,
                    "name": fund["name"],
                    "units": double.parse(units.text),
                    "buy": double.parse(buy.text),
                  });
                });
                saveData();
              }
              Navigator.pop(context);
            },
            child: const Text("SAVE"),
          )
        ],
      ),
    );
  }

  // ================= TOTALS =================
  Future<Map<String, double>> calculateTotals() async {
    double invested = 0, current = 0;

    for (var member in familyData.values) {
      for (var fund in member) {
        final live = await getLiveNav(fund["code"]);
        if (live != null) {
          invested += fund["units"] * fund["buy"];
          current += fund["units"] * live["nav"];
        }
      }
    }
    return {
      "invested": invested,
      "current": current,
      "profit": current - invested,
    };
  }

  // ================= CHART =================
  Widget profitChart(double invested, double current) {
    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: invested,
              title: "Invested",
              color: Colors.blue,
              radius: 70,
            ),
            PieChartSectionData(
              value: current - invested,
              title: "Profit",
              color: (current - invested) >= 0 ? Colors.green : Colors.red,
              radius: 70,
            ),
          ],
        ),
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family MF Tracker Pro"),
        actions: [
          IconButton(onPressed: addMember, icon: const Icon(Icons.person_add)),
        ],
      ),
      body: familyData.isEmpty
          ? const Center(child: Text("No Family Members Added"))
          : ListView(
        children: familyData.entries.map((entry) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(entry.key),
              children: [
                ...entry.value.map((fund) {
                  return FutureBuilder(
                    future: getLiveNav(fund["code"]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const LinearProgressIndicator();
                      }

                      final nav = (snapshot.data as Map)["nav"];
                      final invested = fund["units"] * fund["buy"];
                      final current = fund["units"] * nav;
                      final gain = current - invested;
                      final gainPct = invested > 0 ? (gain / invested * 100) : 0;

                      return ListTile(
                        title: Text(fund["name"]),
                        subtitle: Text(
                          "Invested ₹${invested.toStringAsFixed(2)} | "
                              "Current ₹${current.toStringAsFixed(2)}",
                        ),
                        trailing: Text(
                          "${gain >= 0 ? "+" : ""}${gain.toStringAsFixed(2)}\n(${gainPct.toStringAsFixed(2)}%)",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: gain >= 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onLongPress: () {
                          setState(() {
                            entry.value.remove(fund);
                            saveData();
                          });
                        },
                      );
                    },
                  );
                }),
                TextButton.icon(
                  onPressed: () => addFund(entry.key),
                  icon: const Icon(Icons.add),
                  label: const Text("Add Investment"),
                )
              ],
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: FutureBuilder(
        future: calculateTotals(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox(height: 60);
          final t = snapshot.data as Map<String, double>;
          return Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "🌍 Net Worth: ₹${t["current"]!.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "📈 Profit / Loss: ₹${t["profit"]!.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: t["profit"]! >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                profitChart(t["invested"]!, t["current"]!),
              ],
            ),
          );
        },
      ),
    );
  }
}
