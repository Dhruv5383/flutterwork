import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // 🔥 Comment this line if Firebase not configured
//   await Firebase.initializeApp();
//
//   runApp(const MFTrackerApp());
// }
//
// class MFTrackerApp extends StatelessWidget {
//   const MFTrackerApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MFHomePage(),
//     );
//   }
// }

class MFHomePage extends StatefulWidget {
  const MFHomePage({super.key});

  @override
  State<MFHomePage> createState() => _MFHomePageState();
}

class _MFHomePageState extends State<MFHomePage> {
  Map<String, List<Map<String, dynamic>>> familyData = {};
  bool firebaseSync = false;

  final firestore = FirebaseFirestore.instance;

  // ================= STORAGE =================
  Future<void> saveLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("familyData", jsonEncode(familyData));
  }

  Future<void> loadLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("familyData");
    if (data != null) {
      familyData = Map<String, List<Map<String, dynamic>>>.from(
        jsonDecode(data).map(
              (k, v) => MapEntry(k, List<Map<String, dynamic>>.from(v)),
        ),
      );
    }
  }

  // ================= FIREBASE =================
  Future<void> saveCloud() async {
    if (!firebaseSync) return;
    await firestore.collection("family_mf").doc("data").set(familyData);
  }

  Future<void> loadCloud() async {
    if (!firebaseSync) return;
    final snap = await firestore.collection("family_mf").doc("data").get();
    if (snap.exists) {
      familyData = Map<String, List<Map<String, dynamic>>>.from(
        snap.data()!.map(
              (k, v) => MapEntry(k, List<Map<String, dynamic>>.from(v)),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadLocal().then((_) => setState(() {}));
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
                saveLocal();
                saveCloud();
              }
              Navigator.pop(context);
            },
            child: const Text("ADD"),
          )
        ],
      ),
    );
  }

  void showSavedMessage(String member, String fund, double units, double buy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "✅ Saved for $member\n$fund\nUnits: $units | Buy NAV: ₹$buy",
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
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
                final unitsVal = double.parse(units.text);
                final buyVal = double.parse(buy.text);
                setState(() {
                  familyData[member]!.add({
                    "code": code.text,
                    "name": fund["name"],
                    "units": double.parse(units.text),
                    "buy": double.parse(buy.text),
                  });
                });
                saveLocal();
                saveCloud();
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
  Future<Map<String, double>> totals() async {
    double invested = 0, current = 0;
    for (var m in familyData.values) {
      for (var f in m) {
        final live = await getLiveNav(f["code"]);
        if (live != null) {
          invested += f["units"] * f["buy"];
          current += f["units"] * live["nav"];
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
  Widget chart(double invested, double current) {
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(sections: [
          PieChartSectionData(value: invested, title: "Invested", color: Colors.blue),
          PieChartSectionData(
            value: current - invested,
            title: "Profit",
            color: (current - invested) >= 0 ? Colors.green : Colors.red,
          ),
        ]),
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
          Switch(
            value: firebaseSync,
            onChanged: (v) async {
              firebaseSync = v;
              if (v) await loadCloud();
              setState(() {});
            },
          ),
          IconButton(onPressed: addMember, icon: const Icon(Icons.person_add)),
        ],
      ),
      body: ListView(
        children: familyData.entries.map((e) {
          return Card(
            child: ExpansionTile(
              title: Text(e.key),
              children: [
                ...e.value.map((f) {
                  return FutureBuilder(
                    future: getLiveNav(f["code"]),
                    builder: (c, s) {
                      if (!s.hasData) return const LinearProgressIndicator();
                      final nav = (s.data as Map)["nav"];
                      final invested = f["units"] * f["buy"];
                      final current = f["units"] * nav;
                      final gain = current - invested;

                      return ListTile(
                        title: Text(f["name"]),
                        subtitle: Text("₹${invested.toStringAsFixed(2)} → ₹${current.toStringAsFixed(2)}"),
                        trailing: Text(
                          gain.toStringAsFixed(2),
                          style: TextStyle(color: gain >= 0 ? Colors.green : Colors.red),
                        ),
                        onLongPress: () {
                          setState(() {
                            e.value.remove(f);
                            saveLocal();
                            saveCloud();
                          });
                        },
                      );
                    },
                  );
                }),
                TextButton.icon(
                  onPressed: () => addFund(e.key),
                  icon: const Icon(Icons.add),
                  label: const Text("Add Investment"),
                )
              ],
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: FutureBuilder(
        future: totals(),
        builder: (c, s) {
          if (!s.hasData) return const SizedBox(height: 80);
          final t = s.data as Map<String, double>;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("🌍 Net Worth: ₹${t["current"]!.toStringAsFixed(2)}"),
              Text("📈 Profit: ₹${t["profit"]!.toStringAsFixed(2)}"),
              chart(t["invested"]!, t["current"]!)
            ],
          );
        },
      ),
    );
  }
}
